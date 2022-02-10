import 'package:flutter/material.dart';

class BodyContent extends StatelessWidget {
  const BodyContent({
    Key? key,
    required this.child,
    required this.margin, this.shift = false,
  }) : super(key: key);

  final Widget child;
  final double margin;
  final bool shift;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        top: margin,
      ),
      constraints: BoxConstraints(minHeight: size.height * 0.8),
      //height: size.height * 0.78, -65
      width: shift ? size.width -65  : double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(35))),
      child: child,
    );
  }
}
