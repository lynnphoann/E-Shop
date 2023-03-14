import 'package:eshop/Providers/Product.dart';
import 'package:eshop/Providers/Products.dart';
import 'package:flutter/material.dart';

import 'package:eshop/Widgets/cardItem.dart';

import '../Providers/Cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  // final String photoId;
  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
    // required this.photoId,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get order {
    return [..._orders];
  }

  void addOrder(List<CartItem> products, double total) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: total,
        products: products,
        dateTime: DateTime.now(),
      ),
    );

    notifyListeners();
  }
}
