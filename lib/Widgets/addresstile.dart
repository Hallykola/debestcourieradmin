
import 'package:courieradmin/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddressTile extends StatelessWidget {
  const AddressTile({
    Key? key,
    required this.Svgsrc,
    required this.name,
    required this.address,
    required this.phone,
  }) : super(key: key);
  final String Svgsrc;
  final String name;
  final String address;
  final String phone;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: SvgPicture.asset(
            Svgsrc,
            height: 30,
            color: kPrimaryColor,
          ),
        ),
        Expanded(
          child: RichText(
              text: TextSpan(children: [
            TextSpan(
                text: '$phone \n',
                style: TextStyle(color: Colors.black.withOpacity(0.5))),
            TextSpan(
                text: '$name \n',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
                    
            TextSpan(
                text: address,
                style: TextStyle(color: Colors.black.withOpacity(0.5))),
          ])),
        ),
      ],
    );
  }
}
