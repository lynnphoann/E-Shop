// ignore: file_names
import 'package:eshop/Widgets/product_grid.dart';
import 'package:flutter/material.dart';

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({super.key});

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _favOrNot = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Eshop"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 0,
                child: Text("All Products"),
              ),
              const PopupMenuItem(
                value: 1,
                child: Text("Favorite"),
              )
            ],
            onSelected: (value) {
              setState(
                () {
                  if (value == 0) {
                    _favOrNot = true;
                  } else if (value == 1) {
                    _favOrNot = false;
                  }
                },
              );
            },
          ),
        ],
      ),
      body: Product_grids(favOrNot: _favOrNot),
    );
  }
}
