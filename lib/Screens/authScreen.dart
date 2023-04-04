import 'dart:math';

import 'package:eshop/Screens/LogInOutScreen.dart';
import 'package:eshop/Widgets/customLogBtn.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 236, 236, 238),
        padding: EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Flexible(
              child: Text(
                "Welcome to E-Shop",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            CustomLogBtn(
              actionOntap: () {
                return Navigator.of(context)
                    .pushNamed(LogInOutScreen.routeName, arguments: false);
              },
              btnColor: Color.fromARGB(255, 22, 166, 97),
              title: "Sign in",
              fontColor: Color.fromARGB(255, 238, 237, 237),
            ),
            SizedBox(
              height: 50,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    " Or ",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            CustomLogBtn(
              actionOntap: () {
                return Navigator.of(context)
                    .pushNamed(LogInOutScreen.routeName, arguments: true);
              },
              btnColor: Colors.white,
              title: "Sign up",
              fontColor: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
