import 'package:eshop/Providers/Order.dart' show Orders;
import 'package:eshop/Widgets/app_drawer.dart';
import 'package:eshop/Widgets/orderItem.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});
  static const routename = "/OrderScreen";

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late Future _orderFuture;

  Future fetchOrder() {
    return Provider.of<Orders>(context, listen: false).fetchOrderData();
  }

  @override
  void initState() {
    _orderFuture = fetchOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final OrderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Order"),
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: fetchOrder,
        child: FutureBuilder(
          future: _orderFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              );
            } else {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Something is wrong!"),
                );
              } else {
                return Consumer<Orders>(
                  builder: (context, OrderData, child) {
                    return ListView.builder(
                      itemCount: OrderData.order.length,
                      itemBuilder: (context, index) {
                        return OrderItem(ordData: OrderData.order[index]);
                      },
                    );
                  },
                );
              }
            }
          },
        ),
      ),
    );
  }
}
