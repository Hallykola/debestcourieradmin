
import 'package:flutter/material.dart';

class MyFormInput extends StatelessWidget {
  const MyFormInput({
    Key? key,
    required this.title,
    required this.hintText,
    required this.press,
    required this.controller,
    this.type = TextInputType.name,
    this.hide = false,
  }) : super(key: key);
  final String title;
  final String hintText;
  final Function(String?) press;
  final TextEditingController controller;
  final TextInputType type;
  final bool hide;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.w500)),
        // const SizedBox(
        //   height: 5,
        // ),
        TextFormField(
          controller: controller,
          onSaved: press,
          decoration: InputDecoration(hintText: hintText),
          keyboardType: type,
          obscureText: hide,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
