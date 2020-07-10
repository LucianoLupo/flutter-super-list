import 'package:flutter/material.dart';

import 'package:super_list/src/bloc/products_bloc.dart';
import 'package:super_list/src/providers/db_provider.dart';

class ProductsListPage extends StatelessWidget {
  final productsBloc = new ProductsBloc();

  @override
  Widget build(BuildContext context) {
    productsBloc.getProducts();

    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: productsBloc.deleteAllProducts,
          )
        ],
      ),
      body: _productsListBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: () {
          Navigator.pushNamed(
            context,
            'new_product',
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _productsListBody() {
    return StreamBuilder<List<ProductModel>>(
      stream: productsBloc.productsStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final products = snapshot.data;

        if (products.length == 0) {
          return Center(
            child: Text('No hay información'),
          );
        }

        _addOne(ProductModel product) {
          product.purchasedQuantity += 1;
          productsBloc.updateProduct(product);
        }

        return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, i) => Dismissible(
                key: UniqueKey(),
                background: Container(color: Colors.red),
                onDismissed: (direction) =>
                    productsBloc.deleteProduct(products[i].id),
                child: ListTile(
                  leading: Icon(Icons.cloud_queue,
                      color: Theme.of(context).primaryColor),
                  title: Text(
                      '${products[i].name} ${products[i].purchasedQuantity}/${products[i].expectedQuantity}'),
                  subtitle: Text('ID: ${products[i].id}'),
                  trailing: Icon(Icons.plus_one, color: Colors.grey),
                  onTap: () => _addOne(products[i]),
                )));
      },
    );
  }
}
