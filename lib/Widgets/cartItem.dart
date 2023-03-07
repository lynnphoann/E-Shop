import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:eshop/Providers/Cart.dart';

class CardItem extends StatelessWidget {
  final String id;
  final String productid;
  final double price;
  final String title;
  final int quantity;
  const CardItem({
    Key? key,
    required this.id,
    required this.productid,
    required this.price,
    required this.title,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).delete_item(productid);
      },
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        child: Icon(
          Icons.delete_outline_rounded,
          color: Colors.white,
          size: 35,
        ),
        alignment: Alignment.centerRight,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            leading: SizedBox(
              height: 50,
              width: 50,
              child: CircleAvatar(
                backgroundColor: Colors.green,
                child: FittedBox(
                    child: Padding(
                        padding: EdgeInsets.all(2),
                        child: Text(
                          "\$$price",
                          style: TextStyle(color: Colors.white),
                        ))),
              ),
            ),
            title: Text(title),
            subtitle: Text("Total: \$${(price * quantity)}"),
            trailing: Text("$quantity x"),
          ),
        ),
      ),
    );
  }
}
