import 'package:flutter/material.dart';

class LogInOutScreen extends StatefulWidget {
  final bool switchForm;
  const LogInOutScreen({
    Key? key,
    required this.switchForm,
  }) : super(key: key);

  @override
  State<LogInOutScreen> createState() => _LogInOutScreenState();
}

class _LogInOutScreenState extends State<LogInOutScreen> {
  @override
  Widget build(BuildContext context) {
    Map<String, String?> _authData = {
      'email': '',
      'password': '',
    };
    final _passwordController = TextEditingController();
    final _FormKey = GlobalKey<FormState>();
    bool _isLoading = false;
    void _submit() {
      if (!_FormKey.currentState!.validate()) {
        // Invalid!
        return;
      }
      _FormKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });

      setState(() {
        _isLoading = false;
      });
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
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
                          (widget.switchForm) ? "Sign up" : "Sign In",
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
                          _authData['email'] = value;
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
                            _authData['password'] = value;
                          },
                          decoration:
                              CustomDecorationForm("Enter your Password"),
                        ),
                      ),
                      widget.switchForm
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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 17),
                            backgroundColor: Colors.green,
                          ),
                          child: Text(widget.switchForm ? "Create" : "Confirm"),
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
