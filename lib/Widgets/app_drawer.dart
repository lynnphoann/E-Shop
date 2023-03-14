import 'package:eshop/Screens/orderScreen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("EShop!"),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(Icons.shopping_bag_outlined),
            title: Text("Shop"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed("/");
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text("Order"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrderScreen.routename);
            },
          )
        ],
      ),
    );
  }
}
