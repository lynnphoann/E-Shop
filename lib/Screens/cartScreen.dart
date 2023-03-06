import 'package:eshop/Providers/Cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const routename = "/cartScreen";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                      label: Text(
                        "\$${cart.totalAmount}",
                        style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .titleMedium
                              ?.color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      backgroundColor: Colors.green),
                  TextButton(onPressed: () {}, child: Text("ORDERNOW"))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
