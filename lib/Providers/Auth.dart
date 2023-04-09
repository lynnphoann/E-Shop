import 'dart:async';
import 'dart:convert';

import 'package:eshop/Models/httpexception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expirtDate;
  String? _userId;
  Timer? _authTimer;

  bool swithcy = false;
  bool get isAuth {
    return token != null;
  }

  String? get userId {
    return _userId;
  }

  String? get token {
    if (_expirtDate != null &&
        _expirtDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

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

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken']!;
      _userId = responseData['localId']!;
      _expirtDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      notifyListeners();

      // logOut();
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

  void logOut() {
    _token = null;
    _expirtDate = null;
    _userId = null;

    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
  }

  void autoLogOut() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final ExpTime = _expirtDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: 5), logOut);
  }
}
