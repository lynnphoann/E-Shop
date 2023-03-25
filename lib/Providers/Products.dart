import 'dart:convert';

import 'Product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isfavorite).toList();
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
            "isFavorite": product.isfavorite,
          }));

      final newProduct = Product(
        id: json.decode(response.body)["name"],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
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
          'isFavorite': upProduct.isfavorite,
          'price': upProduct.price,
        }));
    _items[productIndex] = upProduct;
    notifyListeners();
  }

  void deleteProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
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
                imageUrl: value["imageUrl"]));
      });
      _items = networkData;
      notifyListeners();
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }
}
