import 'package:eshop/Providers/Order.dart';
import 'package:eshop/Widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});
  static const routename = "/OrderScreen";
  @override
  Widget build(BuildContext context) {
    final OrderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Order"),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: OrderData.order.length,
        itemBuilder: (context, index) {
          OrderItem(
            id: OrderData.order[index].id,
            amount: OrderData.order[index].amount,
            products: OrderData.order[index].products,
            dateTime: OrderData.order[index].dateTime,
          );
        },
      ),
    );
  }
}
