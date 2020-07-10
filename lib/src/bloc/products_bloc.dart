import 'dart:async';

import 'package:super_list/src/providers/db_provider.dart';

class ProductsBloc {
  static final ProductsBloc _singleton = new ProductsBloc._internal();

  factory ProductsBloc() {
    return _singleton;
  }

  ProductsBloc._internal() {
    getProducts();
  }

  final _productsController = StreamController<List<ProductModel>>.broadcast();

  Stream<List<ProductModel>> get productsStream => _productsController.stream;

  dispose() {
    _productsController?.close();
  }

  getProducts() async {
    _productsController.sink.add(await DBProvider.db.getAllProducts());
  }

  addProduct(ProductModel product) async {
    await DBProvider.db.newProduct(product);
    getProducts();
  }

  updateProduct(ProductModel product) async {
    await DBProvider.db.updateProduct(product);
    getProducts();
  }

  deleteProduct(int id) async {
    await DBProvider.db.deleteProduct(id);
    getProducts();
  }

  deleteAllProducts() async {
    await DBProvider.db.deleteAllProducts();
    getProducts();
  }
}
