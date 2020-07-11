import 'package:flutter/material.dart';

import 'package:super_list/src/bloc/products_bloc.dart';
import 'package:super_list/src/providers/db_provider.dart';

class ProductsListPage extends StatelessWidget {
  final productsBloc = new ProductsBloc();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    productsBloc.getProducts();

    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('AlertDialog Title'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('This is a demo alert dialog.'),
                  Text('Would you like to approve of this message?'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Approve'),
                onPressed: () {
                  productsBloc.deleteAllProducts();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: _showMyDialog,
          )
        ],
      ),
      body: _productsListBody(),
      bottomNavigationBar: new BottomAppBar(
        notchMargin: 3.0,
        shape: CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        color: Colors.red,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              color: Colors.white,
              onPressed: () {
                _scaffoldKey.currentState.showBottomSheet((context) =>
                    Container(
                        color: Colors.red, height: 250.0, child: Container()));
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            'new_product',
          );
        },
        child: new Icon(Icons.add),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),

      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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

        _removeOne(ProductModel product) {
          product.purchasedQuantity -= 1;
          productsBloc.updateProduct(product);
        }

        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, i) => Dismissible(
            key: UniqueKey(),
            background: Container(color: Colors.red),
            onDismissed: (direction) =>
                productsBloc.deleteProduct(products[i].id),
            child: Center(
              child: Container(
                  margin: const EdgeInsets.only(top: 20.0, bottom: 5.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200]),
                  height: 80,
                  width: 375,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(Icons.account_circle, size: 48),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('${products[i].name}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)),
                                SizedBox(height: 2),
                                Text(
                                  ' ${products[i].description}',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ]),
                        ),
                        SizedBox(width: 12),
                        IconButton(
                          splashColor: Colors.green,
                          icon: Icon(Icons.remove),
                          onPressed: () => _removeOne(products[i]),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(minWidth: 50.0),
                          child: Text(
                            '${products[i].purchasedQuantity}/${products[i].expectedQuantity}',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        IconButton(
                          splashColor: Colors.green,
                          icon: Icon(Icons.add),
                          onPressed: () => _addOne(products[i]),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        );
      },
    );
  }
}

// child: ListTile(
//   leading: Icon(Icons.cloud_queue,
//       color: Theme.of(context).primaryColor),
//   title: Text(
//       '${products[i].name} ${products[i].purchasedQuantity}/${products[i].expectedQuantity}'),
//   subtitle: Text('ID: ${products[i].id}'),
//   trailing: Icon(Icons.plus_one, color: Colors.grey),
//   onTap: () => _addOne(products[i]),
// ),
