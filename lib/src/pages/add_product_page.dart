import 'dart:io';

import 'package:flutter/material.dart';
import 'package:super_list/src/bloc/products_bloc.dart';
import 'package:super_list/src/models/product_model.dart';

class AddProductPage extends StatefulWidget {
  static final String routeName = 'settings';

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final productsBloc = new ProductsBloc();

  int id;
  String uuid;
  int expectedQuantity = 10;
  int purchasedQuantity = 0;
  String name = "producto";
  String description = "description";

  TextEditingController _textController;

  @override
  void initState() {
    super.initState();

    _textController = new TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: new AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black87, size: 26.0),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                'Agregar Producto',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black87),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: ListView(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 20.0, bottom: 5.0),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.07),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[100]),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: TextField(
                    style: TextStyle(fontSize: 18.0),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Nombre',
                    ),
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 20.0, bottom: 5.0),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.07),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[100]),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: TextField(
                    style: TextStyle(fontSize: 18.0),
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Descripción'),
                    onChanged: (value) {
                      description = value;
                    },
                  ),
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 20.0, right: 0, top: 20.0, bottom: 5.0),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.07),
                                spreadRadius: 5,
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[100]),
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: TextField(
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18.0),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'Comprado'),
                          onChanged: (value) {
                            purchasedQuantity = int.parse(value);
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 20.0, right: 20, top: 20.0, bottom: 5.0),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.07),
                                spreadRadius: 5,
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[100]),
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: TextField(
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18.0),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Por Comprar'),
                          onChanged: (value) {
                            expectedQuantity = int.parse(value);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: createButton(context),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget createButton(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(
              left: 20.0, right: 20, top: 30.0, bottom: 5.0),
          height: 50.0,
          child: RaisedButton(
            onPressed: () => _addProduct(context),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0)),
            padding: EdgeInsets.all(0.0),
            child: Ink(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(50, 215, 95, 1),
                      Color.fromRGBO(50, 215, 95, 1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.07),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                constraints: BoxConstraints(minHeight: 50.0),
                alignment: Alignment.center,
                child: Text(
                  "Agregar Producto",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _addProduct(BuildContext context) async {
    if (name != null) {
      final product = ProductModel(
          name: name,
          expectedQuantity: expectedQuantity,
          purchasedQuantity: purchasedQuantity,
          description: description);
      productsBloc.addProduct(product);

      if (Platform.isIOS) {
        Future.delayed(Duration(milliseconds: 750), () {
          Navigator.of(context).pop();
        });
      } else {
        Navigator.of(context).pop();
      }
    }
  }
}
