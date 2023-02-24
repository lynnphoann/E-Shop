// ignore: file_names
import 'package:eshop/Widgets/product_grid.dart';
import 'package:flutter/material.dart';

class ProductOverviewScreen extends StatelessWidget {
  const ProductOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Eshop")),
      body: Product_grids(),
    );
  }
}
