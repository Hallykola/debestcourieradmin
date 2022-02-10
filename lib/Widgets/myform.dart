
import 'package:flutter/material.dart';

import 'myforminput.dart';

class MyForm extends StatelessWidget {
  const MyForm({
    Key? key,
    required this.title,
    required this.details,
  }) : super(key: key);
  final String title;
  final List<Map<String, dynamic>> details;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(vertical: 30),
            child: Text(title,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.black.withOpacity(0.5)))),
        Container(
          margin: const EdgeInsets.only(top: 0, left: 20, right: 20),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Form(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              details.length,
              (index) => MyFormInput(
                title: details[index]['title'],
                hintText: details[index]['hintText'],
                press: details[index]['press'],
                controller: details[index]['controller'],
                type: details[index]['type'] ?? TextInputType.name,
                hide: details[index]['hide'] ?? false,
              ),
            ),
          )),
        )
      ],
    );
  }
}

