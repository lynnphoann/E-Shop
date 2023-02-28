import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:eshop/Providers/Product.dart';
import 'package:eshop/Providers/Products.dart';
import 'package:eshop/Widgets/productItem.dart';

class Product_grids extends StatefulWidget {
  final bool favOrNot;
  Product_grids({
    Key? key,
    required this.favOrNot,
  }) : super(key: key);

  @override
  State<Product_grids> createState() => _Product_gridsState();
}

class _Product_gridsState extends State<Product_grids> {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final products =
        widget.favOrNot ? productData.items : productData.favoriteItems;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: products[index],
        child: ProductItem(),
      ),
      itemCount: products.length,
      padding: const EdgeInsets.all(10),
    );
  }
}
