import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Providers/Order.dart' as ord;

class OrderItem extends StatelessWidget {
  final ord.OrderItem ordData;

  const OrderItem({
    Key? key,
    required this.ordData,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        // leading: Padding(
        //   padding: EdgeInsets.all(5),
        //   child: ClipRRect(
        //     borderRadius: BorderRadius.circular(13),
        //   ),
        // ),

        title: Text("\$${ordData.amount}"),
        subtitle: Text(
          DateFormat('dd MM yyyy hh:mm').format(ordData.dateTime),
        ),
        trailing: IconButton(
          icon: Icon(Icons.expand_more),
          onPressed: () {},
        ),
      ),
    );
  }
}
