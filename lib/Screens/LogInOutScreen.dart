import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LogInOutScreen extends StatelessWidget {
  final bool switchForm;
  const LogInOutScreen({
    Key? key,
    required this.switchForm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Container(
        color: Color.fromARGB(255, 245, 243, 243),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Center(
                  child: Text(
                    (switchForm) ? "Sing up" : "Sign In",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Form(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 10),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            label: Text("Enter Your Email"),
                            labelStyle: TextStyle(fontWeight: FontWeight.w600),
                            floatingLabelStyle: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Form(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 10),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          label: Text("Enter Your Password"),
                          labelStyle: TextStyle(fontWeight: FontWeight.w600),
                          floatingLabelStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
