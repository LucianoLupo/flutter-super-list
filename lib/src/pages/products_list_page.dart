import 'dart:math';
import 'package:flutter/material.dart';

import 'package:super_list/src/bloc/products_bloc.dart';
import 'package:super_list/src/providers/db_provider.dart';

class ProductsListPage extends StatelessWidget {
  final productsBloc = new ProductsBloc();

  @override
  Widget build(BuildContext context) {
    productsBloc.getProducts();

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Scaffold(
            extendBody: true,
            appBar: new AppBar(
              title: Text(
                'Productos',
                style: TextStyle(
                  color: Colors.black87,
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Color.fromRGBO(0, 0, 0, 0.3),
                  ),
                  onPressed: () => {},
                )
              ],
              backgroundColor: Colors.transparent,
              elevation: 0.0,
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
                    icon: Icon(
                      Icons.delete_forever,
                      color: Colors.white,
                    ),
                    onPressed: () => _showMyDialog(context),
                  )
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
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
          ),
        ],
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

        _removeOne(ProductModel product) {
          product.purchasedQuantity -= 1;
          productsBloc.updateProduct(product);
        }

        _containerColor(ProductModel product) {
          if (product.purchasedQuantity >= 0) {
            double counter =
                product.purchasedQuantity / product.expectedQuantity;
            double delta = exp(-10 * exp(-6 * counter));
            //print(
            //    '${product.id} === ${product.purchasedQuantity / product.expectedQuantity} === ${delta} === ${(255 - (255 - 50) * delta)}, ${(255 - (255 - 215 * delta))},${(255 - (255 - 95 * delta))}');
            return Color.fromRGBO(
                ((255 - (255 - 50) * delta)).toInt(),
                ((255 - (255 - 215) * delta)).toInt(),
                ((255 - (255 - 95) * delta)).toInt(),
                1);
          }
          return Colors.grey[100];
        }

        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, i) => Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) =>
                productsBloc.deleteProduct(products[i].id),
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(top: 20.0, bottom: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: _containerColor(products[i]),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.05),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
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
                                    fontSize: 12, color: Colors.black87),
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
                            color: Colors.black87,
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
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      //barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Borrar todos los Productos'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Seguro que queres borrar todos los productos?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Si',
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: () {
                productsBloc.deleteAllProducts();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                'No',
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
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
