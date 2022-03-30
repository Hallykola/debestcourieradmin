import 'package:flutter/material.dart';

class SigninOptions extends StatelessWidget {
  const SigninOptions({
    Key? key,
    required this.press,
    required this.text,
    required this.color,
  }) : super(key: key);
  final Function() press;
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: press,
          child: Container(
            padding: const EdgeInsets.all(18),
            width: 600 * 0.33,
            color: color,
            child: Center(
                child: Text(
              text,
              style: const TextStyle(color: Colors.white),
            )),
          ),
        );
      },
    );
  }
}
