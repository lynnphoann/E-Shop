import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Providers/Cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> emptyOrders = [];

  final String? authToken;
  final String? userId;

  Orders({
    required this.emptyOrders,
    this.authToken,
    this.userId,
  });

  List<OrderItem> get order {
    return [...emptyOrders];
  }

  Future<void> addOrder(List<CartItem> products, double total) async {
    final url = Uri.parse(
        "https://eshop-f10b4-default-rtdb.firebaseio.com/Orders/$userId.json?auth=$authToken");
    final timeStamp = DateTime.now();
    try {
      final response = await http.post(url,
          body: json.encode({
            'amount': total,
            'dateTime': timeStamp.toIso8601String(),
            'products': products
                .map((cartP) => {
                      'id': cartP.id,
                      'price': cartP.price,
                      'title': cartP.title,
                      'quantity': cartP.quantity,
                      'PID': cartP.PId,
                    })
                .toList()
          }));
      emptyOrders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)["name"],
          amount: total,
          products: products,
          dateTime: timeStamp,
        ),
      );

      notifyListeners();
    } catch (error) {
      throw error.toString();
    }
  }

  Future<void> fetchOrderData() async {
    final url = Uri.parse(
        "https://eshop-f10b4-default-rtdb.firebaseio.com/Orders/$userId.json?auth=$authToken");
    try {
      final response = await http.get(url);
      List<OrderItem> emptyCart = [];
      final networkData = json.decode(response.body) as Map<String, dynamic>;
      print(networkData);

      networkData.forEach((key, value) {
        emptyCart.insert(
          0,
          OrderItem(
            id: key,
            amount: value['amount'],
            products: (value['products'] as List<dynamic>)
                .map((e) => CartItem(
                      id: e['id'],
                      title: e['title'],
                      price: e['price'],
                      quantity: e['quantity'],
                      PId: e['PID'],
                    ))
                .toList(),
            dateTime: DateTime.parse(value['dateTime']),
          ),
        );
      });
      emptyOrders = emptyCart;
      notifyListeners();
    } catch (error) {
      throw error.toString();
    }
  }
}
