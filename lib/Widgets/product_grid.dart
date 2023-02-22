import 'package:eshop/Models/Product.dart';
import 'package:eshop/Providers/Products.dart';
import 'package:eshop/Widgets/productItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Product_grids extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final products = productData.items;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => ProductItem(
        id: products[index].id,
        title: products[index].title,
        imageUrl: products[index].imageUrl,
      ),
      itemCount: products.length,
      padding: const EdgeInsets.all(10),
    );
  }
}
