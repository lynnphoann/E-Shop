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
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Are you sure?"),
              content: Text("Do you want to Delete Item?"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    "No",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    "Yes",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            );
          },
        );
      },
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).delete_item(productid);
      },
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: const Icon(
          Icons.delete_outline_rounded,
          color: Colors.white,
          size: 35,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            leading: SizedBox(
              height: 50,
              width: 50,
              child: CircleAvatar(
                backgroundColor: Colors.green,
                child: FittedBox(
                    child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          "\$$price",
                          style: const TextStyle(color: Colors.white),
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
