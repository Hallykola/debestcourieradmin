
import 'package:flutter/material.dart';

// class MyFormInput extends StatelessWidget {
//   const MyFormInput({
//     Key? key,
//     required this.title,
//     required this.hintText,
//     required this.press,
//     required this.controller,
//     this.type = TextInputType.name,
//     this.hide = false,
//   }) : super(key: key);
//   final String title;
//   final String hintText;
//   final Function(String?) press;
//   final TextEditingController controller;
//   final TextInputType type;
//   final bool hide;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(title,
//             style: Theme.of(context)
//                 .textTheme
//                 .headline6!
//                 .copyWith(fontWeight: FontWeight.w500)),
//         // const SizedBox(
//         //   height: 5,
//         // ),
//         TextFormField(
//           controller: controller,
//           onSaved: press,
//           decoration: InputDecoration(hintText: hintText),
//           keyboardType: type,
//           obscureText: hide,
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//       ],
//     );
//   }
// }
class MyFormInput extends StatefulWidget {
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
  State<MyFormInput> createState() => _MyFormInputState();
}

class _MyFormInputState extends State<MyFormInput> {
  bool hide = true;
  @override
  void initState() {
    super.initState();
    hide  =  widget.hide;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.w500)),
        // const SizedBox(
        //   height: 5,
        // ),
        TextFormField(
          controller: widget.controller,
          onSaved: widget.press,
          decoration: widget.hide? InputDecoration(
              hintText: widget.hintText,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      hide = !hide;
                    });
                  },
                  icon: hide? Icon(Icons.visibility_off):
                  Icon(Icons.visibility)),):InputDecoration(
              hintText: widget.hintText,),
          keyboardType: widget.type,
          obscureText: hide,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
