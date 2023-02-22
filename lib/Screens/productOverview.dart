import 'package:eshop/Models/Product.dart';
import 'package:eshop/Widgets/productItem.dart';
import 'package:eshop/Widgets/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProductOverviewScreen extends StatelessWidget {
  ProductOverviewScreen({super.key});
  final List<Product> loadedProducts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Eshop")),
      body: Product_grids(),
    );
  }
}
