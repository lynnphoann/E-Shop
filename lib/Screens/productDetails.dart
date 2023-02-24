import 'package:eshop/Providers/Product.dart';
import 'package:eshop/Providers/Products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  // final String title;
  const ProductDetailsScreen({
    Key? key,
    // required this.title,
  }) : super(key: key);
  static const routeName = "/product-details";
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    Product loadedProduct = Provider.of<Products>(context).findById(id);
    return Scaffold(
      appBar: AppBar(title: Text(loadedProduct.title)),
      body: Container(),
    );
  }
}
