import 'package:eshop/Providers/Product.dart';
import 'package:eshop/Providers/Products.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:eshop/Screens/editProductScreen.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String id;
  final String price;
  const UserProductItem({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.id,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl), maxRadius: 30.0),
        title: Text(title),
        subtitle: Text("\$$price"),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(EditProductScreen.routename, arguments: id);
                },
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              IconButton(
                onPressed: () {
                  Provider.of<Products>(context, listen: false)
                      .deleteProduct(id);
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.error,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
