import 'package:flutter/material.dart';

import '../constants.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    required this.press,
    required this.text,
  }) : super(key: key);

  final Function() press;
  final String text;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Container(
        width: size.width,
        padding: const EdgeInsets.symmetric(vertical: 8),
        margin: const EdgeInsets.symmetric(horizontal: 10),

        decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), bottomRight: Radius.circular(30))),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(text, style: const TextStyle(fontSize: 20, color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
