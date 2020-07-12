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
                style: TextStyle(color: Colors.black87),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 20.0, bottom: 5.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200]),
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    style: TextStyle(fontSize: 22.0),
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
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200]),
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    style: TextStyle(fontSize: 22.0),
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Descripción'),
                    onChanged: (value) {
                      description = value;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 20.0, bottom: 5.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200]),
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Por Comprar'),
                    onChanged: (value) {
                      expectedQuantity = int.parse(value);
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 20.0, bottom: 5.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200]),
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Comprado'),
                    onChanged: (value) {
                      purchasedQuantity = int.parse(value);
                    },
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 20.0, bottom: 5.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[200]),
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text("allalalal"),
                    ),
                    Text("HOLA"),
                    Text("HOLA"),
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
        FlatButton(
          child: Text('Agregar Producto'),
          onPressed: () {
            _addProduct(context);
          },
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
