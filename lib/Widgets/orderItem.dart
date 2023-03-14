import 'dart:math';

import 'package:eshop/Providers/Products.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Providers/Order.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem ordData;

  const OrderItem({
    Key? key,
    required this.ordData,
  }) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool expanded = false;
  double? dynamicHeigh = 120;

  @override
  Widget build(BuildContext context) {
    final productM = Provider.of<Products>(context);

    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            leading: const Text(
              "Total Price:",
              style: TextStyle(fontSize: 18),
            ),
            title: Text("\$${widget.ordData.amount}"),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.ordData.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  expanded = !expanded;
                  dynamicHeigh =
                      widget.ordData.products.length.toDouble() * 120;
                });
              },
            ),
          ),
          if (expanded)
            Container(
              height: dynamicHeigh,
              child: ListView(
                  children: widget.ordData.products
                      .map((e) => Row(
                            children: [
                              Container(
                                margin: EdgeInsets.all(8),
                                height: 100,
                                width: 100,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image.network(
                                    productM.getPhotoById(e.PId),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    e.title,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  subtitle: Text("${e.quantity}x"),
                                  trailing: Text("\$${e.price * e.quantity}"),
                                ),
                              )
                            ],
                          ))
                      .toList()),
            )
        ],
      ),
    );
  }
}
