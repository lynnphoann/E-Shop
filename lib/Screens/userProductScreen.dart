import 'package:eshop/Providers/Products.dart';
import 'package:eshop/Screens/editProductScreen.dart';
import 'package:eshop/Widgets/app_drawer.dart';
import 'package:eshop/Widgets/userProductItems.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({super.key});

  static const routename = "/userProductScreen";
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Products"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routename);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productData.items.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                UserProductItem(
                    imageUrl: productData.items[index].imageUrl,
                    title: productData.items[index].title),
                Divider()
              ],
            );
          },
        ),
      ),
    );
  }
}
