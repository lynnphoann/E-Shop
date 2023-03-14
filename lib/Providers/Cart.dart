import 'package:flutter/widgets.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;
  final String PId;
  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.PId,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  double get totalAmount {
    double amount = 0.00;
    _items.forEach((key, value) {
      amount += value.price * value.quantity;
    });
    return amount;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
          PId: productId,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
          PId: productId,
        ),
      );
    }

    notifyListeners();
  }

  void delete_item(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void singleItemRemove(productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity,
          PId: existingCartItem.PId,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }
}
