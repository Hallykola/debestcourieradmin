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
  int times = 10;

  @override
  void initState() {
    super.initState();
    Profile profile = Profile();
    profile.baseref = 'riderprofiles';
    // profile.getItems(context.read<ProfilesContainer>()
    //     //Provider.of<ProfilesContainer>(context, listen: false),
    //     );
    profile.getXItems(context.read<RidersProfilesContainer>(), 10, "name");
  }

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    bool detailed = context.watch<DashBloc>().detailed;
    List<Map<String, dynamic>> profile =
        context.watch<RidersProfilesContainer>().content;
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

              // SvgPicture.asset('assets/icons/globe.svg')
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
                      await Future.delayed(
                          const Duration(milliseconds: 20), () {});

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
          if (profile.length % 10 == 0)
            TextButton(
                onPressed: () {
                  Profile newprofile = Profile();
                  setState(() {
                    times += 10;
                  });
                  newprofile.getXItems(
                      context.read<RidersProfilesContainer>(), times, "name");

                  // neworder.getNextXItems(context.read<DeliveriesContainer>(),
                  //     10, [context.read<DeliveriesContainer>().content[times-11]['item'].ordertimeepoch], "ordertimeepoch");
                },
                child: Text('Show 10 More')),
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
