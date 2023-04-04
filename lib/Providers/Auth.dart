import 'dart:convert';

import 'package:eshop/Models/httpexception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Auth with ChangeNotifier {
  late String _token;
  late DateTime _expirtDate;
  late String _userId;
  Future<void> httpRequest(
      String email, String password, String inputUrl) async {
    final url = Uri.parse(inputUrl);
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signUp(String email, String password) async {
    return httpRequest(
      email,
      password,
      "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCK0mG_prgTIeIgl9vAUrpBDw_MlI9qCj0",
    );
  }

  Future<void> signIn(String email, String password) async {
    return httpRequest(
      email,
      password,
      "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCK0mG_prgTIeIgl9vAUrpBDw_MlI9qCj0",
    );
  }
}
