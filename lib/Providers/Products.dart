import 'dart:convert';

import 'package:eshop/Models/httpexception.dart';

import 'Product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  String getPhotoById(String id) {
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].id == id) {
        return _items[i].imageUrl;
      }
    }
    notifyListeners();
    return "nothing";
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        "https://eshop-f10b4-default-rtdb.firebaseio.com/products.json");
    try {
      final response = await http.post(url,
          body: json.encode({
            "title": product.title,
            "price": product.price,
            "description": product.description,
            "imageUrl": product.imageUrl,
            "isFavorite": product.isFavorite,
          }));

      final newProduct = Product(
        id: json.decode(response.body)["name"],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        isFavorite: product.isFavorite,
      );
      // _items.add(newProduct);
      _items.insert(0, newProduct);
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product upProduct) async {
    final productIndex = _items.indexWhere((element) => element.id == id);
    final url = Uri.parse(
        "https://eshop-f10b4-default-rtdb.firebaseio.com/products/$id.json");
    await http.patch(url,
        body: json.encode({
          'title': upProduct.title,
          'description': upProduct.description,
          'imageUrl': upProduct.imageUrl,
          'isFavorite': upProduct.isFavorite,
          'price': upProduct.price,
        }));
    _items[productIndex] = upProduct;
    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
        "https://eshop-f10b4-default-rtdb.firebaseio.com/products/$id.json");
    final existingProductId = _items.indexWhere((element) => element.id == id);
    Product? pointerProduct = _items[existingProductId];
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductId, pointerProduct);
      notifyListeners();
      throw HttpException("Couldn't delete the product");
    }

    pointerProduct = null;
  }

  Future<void> fetchAndSet() async {
    final url = Uri.parse(
        "https://eshop-f10b4-default-rtdb.firebaseio.com/products.json");

    try {
      final response = await http.get(url);
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      List<Product> networkData = [];
      jsonData.forEach((key, value) {
        networkData.insert(
            0,
            Product(
                id: key,
                title: value["title"],
                description: value["description"],
                price: value["price"],
                imageUrl: value["imageUrl"],
                isFavorite: value["isFavorite"]));
      });
      _items = networkData;
      notifyListeners();
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }
}
