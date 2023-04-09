import 'package:eshop/Providers/Auth.dart';
import 'package:eshop/Screens/orderScreen.dart';
import 'package:eshop/Screens/userProductScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text("Your Products"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductScreen.routename);
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app_rounded),
            title: Text("Log Out"),
            onTap: () {
              Provider.of<Auth>(context, listen: false).logOut();
              // Navigator.pushReplacementNamed(context, AuthScreen.routeName);
            },
          ),
          Divider()
        ],
      ),
    );
  }
}
