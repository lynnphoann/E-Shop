// ignore: file_names
import 'package:eshop/Providers/Cart.dart';
import 'package:eshop/Providers/Products.dart';
import 'package:eshop/Screens/cartScreen.dart';
import 'package:eshop/Widgets/app_drawer.dart';
import 'package:eshop/Widgets/budge.dart';
import 'package:eshop/Widgets/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({super.key});

  static const routeName = "/productOverviewScree";
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _favOrNot = true;
  bool _loadingScreen = true;
  bool _emptyListSwitch = true;

  Future refreshIndicator() {
    return Provider.of<Products>(context, listen: false).fetchAndSet();
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      try {
        await Provider.of<Products>(context, listen: false)
            .fetchAndSet()
            .then((_) {
          return setState(() {
            _loadingScreen = false;
          });
        });
      } catch (error) {
        setState(() {
          _loadingScreen = false;
          _emptyListSwitch = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Eshop"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 0,
                child: Text("All Products"),
              ),
              const PopupMenuItem(
                value: 1,
                child: Text("Favorite"),
              )
            ],
            onSelected: (value) {
              setState(
                () {
                  if (value == 0) {
                    _favOrNot = true;
                  } else if (value == 1) {
                    _favOrNot = false;
                  }
                },
              );
            },
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) =>
                Budge(value: cart.itemsCount.toString(), child: ch!),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routename);
              },
            ),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: refreshIndicator,
        child: _loadingScreen
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _emptyListSwitch
                ? Product_grids(favOrNot: _favOrNot)
                : const Center(
                    child: Text(
                      "There is No Product",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
      ),
    );
  }
}
