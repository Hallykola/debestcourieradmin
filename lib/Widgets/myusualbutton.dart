import 'package:flutter/material.dart';

import '../constants.dart';

class MyUsualButton extends StatelessWidget {
  const MyUsualButton({
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
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration:  BoxDecoration(
            color: kPrimaryColor,
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), offset: Offset(2,2))],
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Center(
          child: 
              
              Text(text,
                  style: TextStyle(fontSize: 20, color: Colors.white))),
        ),
    
    );
  }
}
