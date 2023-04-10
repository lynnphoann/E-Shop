import 'package:eshop/Providers/Auth.dart';
import 'package:eshop/Providers/Cart.dart';
import 'package:eshop/Providers/Order.dart';
import 'package:eshop/Providers/Products.dart';
import 'package:eshop/Screens/LogInOutScreen.dart';
import 'package:eshop/Screens/authScreen.dart';
import 'package:eshop/Screens/cartScreen.dart';
import 'package:eshop/Screens/editProductScreen.dart';
import 'package:eshop/Screens/orderScreen.dart';
import 'package:eshop/Screens/productDetails.dart';
import 'package:eshop/Screens/productOverview.dart';
import 'package:eshop/Screens/userProductScreen.dart';
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
          ChangeNotifierProvider.value(value: Auth()),
          ChangeNotifierProxyProvider<Auth, Products>(
            create: (context) => Products(emptyItems: []),
            update: (context, authData, previousProducts) => Products(
              authToken: authData.token,
              emptyItems:
                  previousProducts == null ? [] : previousProducts.items,
              userId: authData.userId,
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            create: (context) => Orders(emptyOrders: []),
            update: (context, authData, previousOrders) => Orders(
              emptyOrders: previousOrders == null ? [] : previousOrders.order,
              authToken: authData.token,
              userId: authData.userId,
            ),
          )
        ],
        child: Consumer<Auth>(
          builder: (context, AuthData, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
                textTheme: TextTheme(labelLarge: TextStyle(fontSize: 18)),
                appBarTheme: AppBarTheme(color: Colors.green),
                primaryColor: Colors.deepPurpleAccent,
                // ignore: deprecated_member_use
                accentColor: Colors.deepOrange,
                fontFamily: 'Lato'),
            home: AuthData.isAuth ? ProductOverviewScreen() : AuthScreen(),
            routes: {
              ProductDetailsScreen.routeName: (context) =>
                  ProductDetailsScreen(),
              CartScreen.routename: (context) => CartScreen(),
              OrderScreen.routename: (context) => OrderScreen(),
              UserProductScreen.routename: (context) => UserProductScreen(),
              EditProductScreen.routename: (context) => EditProductScreen(),
              LogInOutScreen.routeName: (context) => LogInOutScreen(),
              // ProductOverviewScreen.routeName: (context) =>
              //     ProductOverviewScreen(),
              AuthScreen.routeName: (context) => AuthScreen(),
            },
          ),
        ));
  }
}
