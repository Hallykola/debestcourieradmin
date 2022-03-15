import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HeaderwithBack extends StatelessWidget {
  const HeaderwithBack({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              'assets/icons/back-arrow.svg',
              color: Colors.white,
              height: 30,
            )),
        const SizedBox(
          height: 20,
        ),
        Text(title,
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.white)),
      ],
    ));
  }
}
