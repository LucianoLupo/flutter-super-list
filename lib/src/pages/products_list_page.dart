import 'package:flutter/material.dart';

import 'package:super_list/src/bloc/products_bloc.dart';
import 'package:super_list/src/pages/products_search_page.dart';
import 'package:super_list/src/utils/double_circular_notched.dart';
import 'package:super_list/src/widgets/product_list_body.dart';

class ProductsListPage extends StatefulWidget {
  @override
  _ProductsListPageState createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
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
              titleSpacing: 20.0,
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Color.fromRGBO(0, 0, 0, 0.87),
                    ),
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: ProductsSearch(),
                      );
                    },
                  ),
                )
              ],
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: ProductsListBody(
                productsBloc, () => productsBloc.getProducts()),
            bottomNavigationBar: Container(
              height: 50,
              child: BottomAppBar(
                notchMargin: 4.0,
                shape: DoubleCircularNotchedButton(), //changed to new class
                clipBehavior: Clip.antiAlias,
                color: Color.fromRGBO(255, 255, 255, 1),
                child: Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    'Productos',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,

            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 32),
                  child: FloatingActionButton(
                    heroTag: "deleteButton",
                    onPressed: () => _showMyDialog(context),
                    child: new Icon(Icons.delete),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                  ),
                ),
                FloatingActionButton(
                  heroTag: "addProductButton",
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      'new_product',
                    );
                  },
                  child: new Icon(Icons.add),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black87,
                )
              ],
            ),

            //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          ),
        ],
      ),
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
