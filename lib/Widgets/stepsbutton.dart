
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class StepButtons extends StatelessWidget {
  const StepButtons({
    Key? key,
    required this.press,
    required this.svgsrc,
    this.active = false,
  }) : super(key: key);
  final Function() press;
  final String svgsrc;
  final bool active;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.grey,
        shape: BoxShape.circle,
      ),
      child: active
          ? IconButton(onPressed: press, icon: SvgPicture.asset(svgsrc))
          : IconButton(
              onPressed: press,
              icon: SvgPicture.asset(
                svgsrc,
                color: kPrimaryColor,
              )),
    );
  }
}
