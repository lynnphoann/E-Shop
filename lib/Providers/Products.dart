import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:eshop/Models/httpexception.dart';

import 'Product.dart';

class Products with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Product> emptyItems = [];

  final String? authToken;
  final String? userId;

  Products({
    required this.emptyItems,
    this.authToken,
    this.userId,
  });

  List<Product> get items {
    return [...emptyItems];
  }

  List<Product> get favoriteItems {
    return emptyItems.where((element) => element.isFavorite).toList();
  }

  Product findById(String id) {
    return emptyItems.firstWhere((element) => element.id == id);
  }

  String getPhotoById(String id) {
    for (int i = 0; i < emptyItems.length; i++) {
      if (emptyItems[i].id == id) {
        return emptyItems[i].imageUrl;
      }
    }
    notifyListeners();
    return "nothing";
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        "https://eshop-f10b4-default-rtdb.firebaseio.com/products.json?auth=$authToken");
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
      // emptyItems.add(newProduct);
      emptyItems.insert(0, newProduct);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateProduct(String id, Product upProduct) async {
    final productIndex = emptyItems.indexWhere((element) => element.id == id);
    // if (productIndex >= 0) {
    final url = Uri.parse(
        "https://eshop-f10b4-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken");
    await http.patch(url,
        body: json.encode({
          'title': upProduct.title,
          'description': upProduct.description,
          'imageUrl': upProduct.imageUrl,
          'isFavorite': upProduct.isFavorite,
          'price': upProduct.price,
        }));
    emptyItems[productIndex] = upProduct;
    notifyListeners();
    // } else {
    //   print("...");
    // }
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
        "https://eshop-f10b4-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken");
    final existingProductId =
        emptyItems.indexWhere((element) => element.id == id);
    Product? pointerProduct = emptyItems[existingProductId];
    emptyItems.removeWhere((element) => element.id == id);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      emptyItems.insert(existingProductId, pointerProduct);
      notifyListeners();
      throw HttpException("Couldn't delete the product");
    }

    pointerProduct = null;
  }

  Future<void> fetchAndSet() async {
    var url = Uri.parse(
        "https://eshop-f10b4-default-rtdb.firebaseio.com/products.json?auth=$authToken");

    try {
      final response = await http.get(url);
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      url = Uri.parse(
          "https://eshop-f10b4-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken");
      final userFavoriteRespone = await http.get(url);
      final userFavoriteData = json.decode(userFavoriteRespone.body);
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
              isFavorite: userFavoriteData == null
                  ? false
                  : userFavoriteData[key] ?? false,
            ));
      });
      emptyItems = networkData;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
