import 'package:eshop/Providers/Products.dart';
import 'package:eshop/Screens/editProductScreen.dart';
import 'package:eshop/Widgets/app_drawer.dart';
import 'package:eshop/Widgets/userProductItems.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({super.key});

  static const routename = "/userProductScreen";

  Future<void> refreshProduct(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSet(true);
  }

  @override
  Widget build(BuildContext context) {
    print("This is building");
    // final productData = Provider.of<Products>(context);
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
        drawer: const AppDrawer(),
        body: FutureBuilder(
            future: refreshProduct(context),
            builder: (context, snapshot) => snapshot.connectionState ==
                    ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Colors.green,
                  ))
                : RefreshIndicator(
                    onRefresh: () => refreshProduct(context),
                    child: Consumer<Products>(
                      builder: (context, productData, _) => Padding(
                        padding: EdgeInsets.all(8),
                        child: ListView.builder(
                          itemCount: productData.items.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                UserProductItem(
                                    price: productData.items[index].price
                                        .toString(),
                                    imageUrl: productData.items[index].imageUrl,
                                    title: productData.items[index].title,
                                    id: productData.items[index].id!),
                                Divider()
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  )));
  }
}
