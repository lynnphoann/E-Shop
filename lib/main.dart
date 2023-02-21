import 'package:eshop/Screens/productDetails.dart';
import 'package:eshop/Screens/productOverview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          appBarTheme: AppBarTheme(color: Colors.green),
          primaryColor: Colors.deepPurpleAccent,
          // ignore: deprecated_member_use
          accentColor: Colors.deepOrange,
          fontFamily: 'lato'),
      home: ProductOverviewScreen(),
      routes: {
        ProductDetailsScreen.routeName: (context) => ProductDetailsScreen()
      },
    );
  }
}
