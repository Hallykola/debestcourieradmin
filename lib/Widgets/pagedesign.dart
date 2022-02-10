import 'package:flutter/material.dart';

import 'bodycontent.dart';

class PageDesign extends StatelessWidget {
  const PageDesign({
    Key? key,
    required this.content,
    required this.header,
    required this.headerHeight,
    required this.fixedLastChild,
    required this.lastChild,
    this.shift = false,
    required this.sideChild,
  }) : super(key: key);

  final Widget content;
  final Widget header;
  final double headerHeight;
  final Widget fixedLastChild;
  final Widget lastChild;
  final bool shift;
  final Widget sideChild;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(children: [
      SingleChildScrollView(
        child: Stack(children: [
          header,
          shift
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (shift)
                      Container(
                          margin: EdgeInsets.only(top: headerHeight + 20),
                          child: sideChild),
                    BodyContent(
                      shift: shift,
                      margin: headerHeight,
                      child: content,
                    ),
                  ],
                )
              : BodyContent(
                  shift: shift,
                  margin: headerHeight,
                  child: content,
                ),
          Positioned(bottom: 0, child: lastChild)
        ]),
      ),
      Positioned(bottom: 0, child: fixedLastChild)
    ]));
  }
}
