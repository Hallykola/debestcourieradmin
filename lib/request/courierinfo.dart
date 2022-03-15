import 'dart:ui';

import 'package:courieradmin/constants.dart';
import 'package:courieradmin/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:flutter_svg/svg.dart';

class CourierInfo extends StatefulWidget {
  CourierInfo({Key? key, required this.order}) : super(key: key);
  final Order order;

  @override
  _CourierInfoState createState() => _CourierInfoState();
}

class _CourierInfoState extends State<CourierInfo> {
  List<String> courierType = [
    'Envelope',
    'Box Pack',
    'Phone',
    'Laptop',
    'Other'
  ];
  int cType = 0;
  bool frangible = false;
  int currentValue = 0;
  TextEditingController detailscontroller = TextEditingController();
  RulerPickerController? _rulerPickerController =
      RulerPickerController(value: 0);

  @override
  void initState() {
    super.initState();
    frangible = ((widget.order.packagefrangible) != "")
        ? (widget.order.packagefrangible == "true")
        : false;
    currentValue =
        (widget.order.packageweight != "" && widget.order.packageweight != null)
            ? int.parse(widget.order.packageweight as String)
            : 0;
    // _rulerPickerController = RulerPickerController(value: initialweight);
    detailscontroller.text = widget.order.packagedetail ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Courier Type',
              style: Theme.of(context).textTheme.headline6!.copyWith(),
            ),
            const SizedBox(
              height: 10,
            ),
            CourierOptionRow(
                initial: (widget.order.packagetype != "" &&
                        widget.order.packagetype != null)
                    ? courierType.indexOf(widget.order.packagetype as String)
                    : 0,
                courierType: courierType,
                onSelected: (value) {
                  setState(() {
                    cType = value;
                  });
                  widget.order.packagetype = courierType[value];
                  print(courierType[value].toString());
                }),
            MyContainer(
                child: DimensionRow(
              order: widget.order,
            )),
            const SizedBox(
              height: 10,
            ),
            MyContainer(
              child: Row(
                children: [
                  const Text(
                    'Frangible?',
                    style: TextStyle(fontSize: 18),
                  ),
                  const Spacer(),
                  Text(
                    frangible ? "Yes" : "No",
                    style: TextStyle(fontSize: 16, color: kPrimaryColor),
                  ),
                  Switch(
                      activeColor: kPrimaryColor,
                      value: ((widget.order.packagefrangible) != "")
                          ? (widget.order.packagefrangible == "true")
                          : frangible,
                      onChanged: (value) {
                        setState(() {
                          frangible = value;
                        });
                        widget.order.packagefrangible = frangible.toString();
                        print(value.toString());
                      }),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MyContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Weight (${currentValue} kg)',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RulerPicker(
                    controller: _rulerPickerController!,
                    beginValue: 0,
                    endValue: 150,
                    initValue: currentValue,
                    scaleLineStyleList: const [
                      ScaleLineStyle(
                          color: Colors.grey, width: 1.5, height: 30, scale: 0),
                      ScaleLineStyle(
                          color: Colors.grey, width: 1, height: 25, scale: 5),
                      ScaleLineStyle(
                          color: Colors.grey, width: 1, height: 15, scale: -1)
                    ],
                    // onBuildRulerScalueText: (index, scaleValue) {
                    //   return ''.toString();
                    // },
                    onValueChange: (value) {
                      setState(() {
                        currentValue = value;
                      });
                      widget.order.packageweight = value.toString();
                    },
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    rulerMarginTop: 8,
                    // marker: Container(
                    //     width: 8,
                    //     height: 50,
                    //     decoration: BoxDecoration(
                    //         color: Colors.red.withAlpha(100),
                    //         borderRadius: BorderRadius.circular(5))),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            MyContainer(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Courier detail',
                  style: TextStyle(fontSize: 16, color: kPrimaryColor),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: detailscontroller,
                  onChanged: (value) {
                    widget.order.packagedetail = value;
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter additional details',
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(12)))),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class MyContainer extends StatelessWidget {
  const MyContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: child);
  }
}

class DimensionRow extends StatefulWidget {
  const DimensionRow({
    Key? key,
    required this.order,
  }) : super(key: key);
  final Order order;

  @override
  State<DimensionRow> createState() => _DimensionRowState();
}

class _DimensionRowState extends State<DimensionRow> {
  TextEditingController heightcontroller = TextEditingController();
  TextEditingController widthcontroller = TextEditingController();
  TextEditingController lengthcontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    heightcontroller.text = widget.order.packageheight ?? "";
    widthcontroller.text = widget.order.packagewidth ?? "";
    lengthcontroller.text = widget.order.packagelength ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        BoxDimension(
          valuecontroller: heightcontroller,
          onChanged: (value) {
            widget.order.packageheight = value;
          },
          title: "Height",
          Svgsrc: 'assets/icons/globe.svg',
        ),
        MyDivider(),
        BoxDimension(
           onChanged: (value) {
            widget.order.packagewidth = value;
          },
          valuecontroller: widthcontroller,
          title: "Width",
          Svgsrc: 'assets/icons/globe.svg',
        ),
        MyDivider(),
        BoxDimension(
           onChanged: (value) {
            widget.order.packagelength = value;
          },
          valuecontroller: lengthcontroller,
          title: "Length",
          Svgsrc: 'assets/icons/globe.svg',
        ),
      ],
    );
  }
}

class MyDivider extends StatelessWidget {
  const MyDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      //padding: const EdgeInsets.symmetric(vertical: 25.0),
      decoration: BoxDecoration(color: Colors.grey.shade100),
      width: 3,
      height: 60,
    );
  }
}

class BoxDimension extends StatelessWidget {
  const BoxDimension({
    Key? key,
    required this.title,
    required this.Svgsrc,
    required this.valuecontroller,
    required this.onChanged,
  }) : super(key: key);
  final String title;
  final String Svgsrc;
  final TextEditingController valuecontroller;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                Svgsrc,
                height: 25,
                color: kPrimaryColor,
              ),
            ),
            Text(title),
          ],
        ),
        SizedBox(
          height: 40,
          width: 60,
          child: TextField(
            controller: valuecontroller,
            keyboardType: TextInputType.number,
            onChanged: (value) => onChanged(value),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade100,
                border: InputBorder.none),
          ),
        ),
        // Text(
        //   '$value cm',
        //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        // ),
      ],
    );
  }
}

class CourierOptionRow extends StatefulWidget {
  const CourierOptionRow(
      {Key? key,
      required this.courierType,
      required this.onSelected,
      required this.initial})
      : super(key: key);
  final List<String> courierType;
  final int initial;
  final Function(int) onSelected;
  @override
  State<CourierOptionRow> createState() => _CourierOptionRowState();
}

class _CourierOptionRowState extends State<CourierOptionRow> {
  List<String>? courierType;
  int selected = 0;
  Function(int)? press;
  @override
  void initState() {
    super.initState();
    courierType = widget.courierType;
    selected = widget.initial;
    press = widget.onSelected;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(
            courierType!.length,
            (index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: CourierType(
                  name: courierType![index],
                  selected: (index == selected),
                  press: () {
                    setState(() {
                      selected = index;
                    });
                    press!(selected);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

class CourierType extends StatelessWidget {
  const CourierType({
    Key? key,
    required this.name,
    this.selected = false,
    required this.press,
  }) : super(key: key);
  final String name;
  final bool selected;
  final GestureTapCallback press;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: selected ? kPrimaryColor : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Text(name),
      ),
    );
  }
}
