
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class IconTextButton extends StatelessWidget {
  const IconTextButton({
    Key? key,
    required this.Svgsrc,
    required this.text,
    required this.press,
  }) : super(key: key);
  final String Svgsrc;
  final String text;
  final GestureTapCallback press;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Row(
        children: [
          SvgPicture.asset(
            Svgsrc,
            height: 30,
            color: kPrimaryColor,
          ),
          Text(
            text,
            style: TextStyle(color: kPrimaryColor),
          ),
        ],
      ),
    );
  }
}
