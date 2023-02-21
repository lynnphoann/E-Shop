import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
    return Scaffold(
      appBar: AppBar(title: Text("title")),
      body: Container(),
    );
  }
}
