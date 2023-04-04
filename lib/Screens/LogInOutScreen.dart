import 'dart:io';

import 'package:eshop/Providers/Auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogInOutScreen extends StatefulWidget {
  const LogInOutScreen({
    Key? key,
  }) : super(key: key);
  static const routeName = "/LogInOutScreen";
  @override
  State<LogInOutScreen> createState() => _LogInOutScreenState();
}

class _LogInOutScreenState extends State<LogInOutScreen> {
  @override
  Widget build(BuildContext context) {
    final bool switchForm = ModalRoute.of(context)!.settings.arguments as bool;

    Map<String, String> _authData = {
      'email': '',
      'password': '',
    };
    final _passwordController = TextEditingController();
    final _FormKey = GlobalKey<FormState>();
    bool _isLoading = false;

    void _showDialog(String message) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('An Error Occurred!'),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }

    Future<void> _submit() async {
      if (!_FormKey.currentState!.validate()) {
        // Invalid!
        return;
      }
      _FormKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        if (switchForm) {
          await Provider.of<Auth>(context, listen: false)
              .signUp(_authData["email"]!, _authData["password"]!);
        } else {
          await Provider.of<Auth>(context, listen: false)
              .signIn(_authData["email"]!, _authData["password"]!);
        }
      } catch (error) {
        var errorMessage =
            'Could not authenticate you. Please try again later.';
        if (error.toString().contains('EMAIL_EXISTS')) {
          errorMessage = 'This email address is already in use.';
        } else if (error.toString().contains('INVALID_EMAIL')) {
          errorMessage = 'This is not a valid email address';
        } else if (error.toString().contains('WEAK_PASSWORD')) {
          errorMessage = 'This password is too weak.';
        } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
          errorMessage = 'Could not find a user with that email.';
        } else if (error.toString().contains('INVALID_PASSWORD')) {
          errorMessage = 'Invalid password.';
        }
        _showDialog(errorMessage);
      }

      setState(() {
        _isLoading = false;
      });
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              return Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
              size: 28,
            )),
        backgroundColor: const Color.fromARGB(255, 245, 243, 243),
        elevation: 0,
        title: Text(""),
      ),
      body: Container(
        color: const Color.fromARGB(255, 245, 243, 243),
        child: _isLoading
            ? const CircularProgressIndicator()
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                child: Form(
                  key: _FormKey,
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      Center(
                        child: Text(
                          (switchForm) ? "Sign up" : "Sign In",
                          style: const TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || !value.contains('@')) {
                            return 'Invalid email!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _authData['email'] = value!;
                        },
                        decoration: CustomDecorationForm("Enter Your Email"),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 3,
                        ),
                        child: TextFormField(
                          obscureText: true,
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.length < 5) {
                              return 'Password is too short!';
                            }
                          },
                          onSaved: (value) {
                            _authData['password'] = value!;
                          },
                          decoration:
                              CustomDecorationForm("Enter your Password"),
                        ),
                      ),
                      switchForm
                          ? Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: TextFormField(
                                  obscureText: true,
                                  validator: (value) {
                                    if (value != _passwordController.text) {
                                      return 'Passwords do not match!';
                                    }
                                  },
                                  decoration: CustomDecorationForm(
                                      "Confirm Your Password")),
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: ElevatedButton(
                          onPressed: () {
                            _submit();
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 17),
                            backgroundColor: Color.fromARGB(255, 22, 166, 97),
                          ),
                          child: Text(switchForm ? "Create" : "Confirm"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  InputDecoration CustomDecorationForm(String title) {
    return InputDecoration(
      label: Text(title),
      labelStyle: const TextStyle(fontWeight: FontWeight.w600),
      floatingLabelStyle: const TextStyle(color: Colors.black),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(30)),
      fillColor: Colors.white,
      filled: true,
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(30)),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}
