import 'package:eshop/Providers/Cart.dart';
import 'package:eshop/Providers/Product.dart';
import 'package:eshop/Screens/productDetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Product pProduct = Provider.of<Product>(context, listen: false);
    Cart cart = Provider.of<Cart>(context, listen: true);
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: GridTile(
          footer: GridTileBar(
            leading: Consumer<Product>(
              builder: (ctx, value, _) {
                return IconButton(
                  color: Theme.of(context).colorScheme.secondary,
                  icon: Icon(value.isfavorite
                      ? Icons.favorite
                      : Icons.favorite_border_outlined),
                  onPressed: () {
                    value.toggleFavorite();
                  },
                );
              },
            ),
            backgroundColor: Colors.black87,
            title: Text(
              pProduct.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              color: Theme.of(context).colorScheme.secondary,
              icon: const Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                cart.addItem(pProduct.id, pProduct.price, pProduct.title);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Add Item to a Cart!",
                      style: TextStyle(fontSize: 18),
                    ),
                    action: SnackBarAction(
                      label: "UNDO",
                      onPressed: () {
                        cart.singleItemRemove(pProduct.id);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(ProductDetailsScreen.routeName,
                  arguments: pProduct.id);
            },
            child: Image.network(
              pProduct.imageUrl,
              fit: BoxFit.cover,
            ),
          )),
    );
  }
}
