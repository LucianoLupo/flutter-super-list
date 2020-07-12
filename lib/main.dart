import 'package:flutter/material.dart';
import 'package:super_list/src/pages/add_product_page.dart';

import 'package:super_list/src/pages/home_page.dart';
import 'package:super_list/src/pages/products_list_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Super List',
      initialRoute: 'products',
      routes: {
        "/": (BuildContext context) => HomePage(),
        'products': (BuildContext context) => ProductsListPage(),
        'new_product': (BuildContext context) => AddProductPage(),
      },
      theme: ThemeData(primaryColor: Colors.deepPurple),
    );
  }
}
