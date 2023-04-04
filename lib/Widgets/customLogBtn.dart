import 'package:flutter/material.dart';

class CustomLogBtn extends StatelessWidget {
  final Function actionOntap;
  final Color btnColor;
  final String title;
  final Color fontColor;
  const CustomLogBtn({
    Key? key,
    required this.actionOntap,
    required this.btnColor,
    required this.title,
    required this.fontColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        return actionOntap();
      },
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 7,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: btnColor,
          ),
          width: MediaQuery.of(context).size.width * 0.8,
          height: 65,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 30,
                color: fontColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
