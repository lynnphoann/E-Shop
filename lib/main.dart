import 'package:eshop/Providers/Cart.dart';
import 'package:eshop/Providers/Order.dart';
import 'package:eshop/Providers/Products.dart';
import 'package:eshop/Screens/cartScreen.dart';
import 'package:eshop/Screens/orderScreen.dart';
import 'package:eshop/Screens/productDetails.dart';
import 'package:eshop/Screens/productOverview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            textTheme: TextTheme(labelLarge: TextStyle(fontSize: 18)),
            appBarTheme: AppBarTheme(color: Colors.green),
            primaryColor: Colors.deepPurpleAccent,
            // ignore: deprecated_member_use
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailsScreen.routeName: (context) => ProductDetailsScreen(),
          CartScreen.routename: (context) => CartScreen(),
          OrderScreen.routename: (context) => OrderScreen(),
        },
      ),
    );
  }
}
