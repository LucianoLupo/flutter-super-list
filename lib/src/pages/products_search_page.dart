import 'package:flutter/material.dart';
import 'package:super_list/src/bloc/products_bloc.dart';
import 'package:super_list/src/widgets/product_list_body.dart';

class ProductsSearch extends SearchDelegate {
  final productsBloc = new ProductsBloc();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        productsBloc.getProducts();
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    productsBloc.searchProducts(query);

    return ProductsListBody(
        productsBloc, () => productsBloc.searchProducts(query));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    productsBloc.searchProducts(query);

    return ProductsListBody(
        productsBloc, () => productsBloc.searchProducts(query));
  }
}
