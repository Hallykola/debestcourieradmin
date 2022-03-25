import 'package:courieradmin/Widgets/profileimage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';
import '../dashboard/dashBloc.dart';
import 'package:provider/provider.dart';

import '../models/categoriescontainer.dart';
import '../models/profile.dart';

class ListOfRiders extends StatefulWidget {
  ListOfRiders({Key? key}) : super(key: key);

  @override
  State<ListOfRiders> createState() => _ListOfRidersState();
}

class _ListOfRidersState extends State<ListOfRiders> {
  String prevCursor = "";
  @override
  void initState() {
    super.initState();
    Profile profile = Profile();
    profile.baseref = 'riderprofiles';
    // profile.getItems(context.read<ProfilesContainer>()
    //     //Provider.of<ProfilesContainer>(context, listen: false),
    //     );
    profile.getXItems(context.read<ProfilesContainer>(), 10, "name");
  }

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    bool detailed = context.watch<DashBloc>().detailed;
    List<Map<String, dynamic>> profile =
        context.watch<ProfilesContainer>().content;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      height: screensize.height * 0.5,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'All Riders',
                style: h2Style,
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: boxDecowhite,
                child: Text('23-4-22 - 23-5-22'),
              ),
              const SizedBox(
                width: 10,
              ),
              SvgPicture.asset('assets/icons/globe.svg')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(flex: 1, child: Text('')),
              Expanded(flex: 2, child: Text('Name')),
              Expanded(flex: 2, child: Text('Email')),
              Expanded(flex: 2, child: Text('Phone number')),
              Expanded(flex: 1, child: Text('Address')),
              Expanded(flex: 1, child: Text('')),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: profile.length,
                itemBuilder: (BuildContext context, int index) {
                  return TableRow(
                    press: () async {
                      setState(() {
                        detailed = Provider.of<DashBloc>(context, listen: false)
                            .detailed;
                      });
                      Provider.of<DashBloc>(context, listen: false)
                          .setDetailed(false);
                     await Future.delayed(const Duration(milliseconds: 20), () {});

                      Provider.of<DashBloc>(context, listen: false)
                          .setFocusedRiderProfile(profile[index]['item']);
                      Provider.of<DashBloc>(context, listen: false)
                          .setDetailed(true);

                    },
                    name: profile[index]['item'].name,
                    email: profile[index]['item'].email,
                    phonenumber: profile[index]['item'].phonenumber,
                    address: profile[index]['item'].address,
                    profilepicurl: (profile[index]['item'].profilepicurl == "")
                        ? '0'
                        : profile[index]['item'].profilepicurl,
                  );
                }),
          ),
          if (prevCursor != "")
            TextButton(
                onPressed: () {
                  print('here e dey o! ${profile.length}');
                  setState(() {
                    prevCursor = profile[9]['item'].name;
                  });
                  Profile neworder = Profile();
                  neworder.baseref = 'riderprofiles';
                  neworder.getPrevXItems(context.read<ProfilesContainer>(), 10,
                      [prevCursor], "name");
                },
                child: Text('Prev 10')),
          TextButton(
              onPressed: () {
                print('item length is ${profile.length - 1}');
                setState(() {
                  prevCursor = profile[9]['item'].name;
                });
                print(prevCursor);
                Profile neworder = Profile();
                neworder.baseref = 'riderprofiles';
                neworder.getNextXItems(context.read<ProfilesContainer>(), 10,
                    [profile[9]['item'].name], "name");
              },
              child: Text('Next 10'))
        ],
      ),
    );
  }
}

class TableRow extends StatelessWidget {
  const TableRow({
    Key? key,
    required this.name,
    required this.email,
    required this.phonenumber,
    required this.address,
    required this.profilepicurl,
    required this.press,
  }) : super(key: key);
  final String name;
  final String email;
  final String phonenumber;
  final String address;
  final String profilepicurl;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: boxDecowhite,
      child: Row(children: [
        const SizedBox(
          width: 20,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          margin: const EdgeInsets.all(6),
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              image: DecorationImage(
                image: NetworkImage(profilepicurl),
              )),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
            flex: 2,
            child: Text(
              name,
              style: bodyLightStyle,
            )),
        Expanded(
            flex: 2,
            child: Text(
              email,
              style: bodyLightStyle,
            )),
        Expanded(
            flex: 2,
            child: Text(
              phonenumber,
              style: bodyLightStyle,
            )),
        Expanded(
            child: Text(
          address,
          style: bodyLightStyle,
        )),
        Expanded(
            child: GestureDetector(
          onTap: press,
          child: const Text(
            "Show Details",
            style: bodyLightStyle,
          ),
        )),
      ]),
    );
  }
}
