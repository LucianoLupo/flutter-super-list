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
  int expectedQuantity;
  int purchasedQuantity;
  String name;
  String description;

  TextEditingController _textController;

  @override
  void initState() {
    super.initState();

    _textController = new TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Agregar Producto'),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5.0),
              child: Text('Settings',
                  style:
                      TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold)),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  helperText: 'Nombre del Producto',
                ),
                onChanged: (value) {
                  name = value;
                },
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  helperText: 'Descripción del Producto',
                ),
                onChanged: (value) {
                  description = value;
                },
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Cantidad Esperada',
                  helperText: 'Cantidad Esperada',
                ),
                onChanged: (value) {
                  expectedQuantity = int.parse(value);
                },
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Cantidad Comprada',
                  helperText: 'Cantidad Comprada',
                ),
                onChanged: (value) {
                  purchasedQuantity = int.parse(value);
                },
              ),
            ),
            Divider(),
            Container(
              child: createButton(context),
            )
          ],
        ));
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
          //utils.abrirScan(context, product);
        });
      } else {
        //utils.abrirScan(context, product);
      }
      Navigator.pushNamed(
        context,
        'products',
      );
    }
  }
}
