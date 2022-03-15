import 'package:courieradmin/Widgets/apptitle.dart';
import 'package:courieradmin/Widgets/mybutton.dart';
import 'package:courieradmin/Widgets/myform.dart';
import 'package:courieradmin/Widgets/pagedesign.dart';
import 'package:courieradmin/Widgets/profileimage.dart';
import 'package:courieradmin/models/categoriescontainer.dart';
import 'package:courieradmin/models/profile.dart';
import 'package:courieradmin/profile/profileBloc.dart';
import 'package:courieradmin/signin/myauth.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../helpers.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  late Profile myprofile;

  late TextEditingController fullnamecontroller;
  late TextEditingController emailcontroller;
  late TextEditingController phonenumbercontroller;
  late TextEditingController addresscontroller;

  @override
  void initState() {
    myprofile = Provider.of<ProfilesContainer>(context, listen: false)
        .content[0]['item'];
    fullnamecontroller = TextEditingController(text: myprofile.name);
    emailcontroller = TextEditingController(text: myprofile.email);
    phonenumbercontroller = TextEditingController(text: myprofile.phonenumber);
    addresscontroller = TextEditingController(text: myprofile.address);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double headerHeight = size.height * 0.2;
    Profile liveprofile = context.watch<ProfilesContainer>().content[0]['item'];
    var mee = DateTime.now().millisecondsSinceEpoch;
    List<Map<String, dynamic>> details;
    details = [
      {
        "title": "Full Name",
        "hintText": "Enter your Full Name",
        "press": (text) {},
        "controller": fullnamecontroller
      },
      {
        "title": "Email Address",
        "hintText": "Enter your Email Address",
        "press": (text) {},
        "controller": emailcontroller,
        "type": TextInputType.emailAddress,
      },
      {
        "title": "Phone Number",
        "hintText": "Enter your Phone Number",
        "press": (text) {},
        "controller": phonenumbercontroller,
        "type": TextInputType.phone,
      },
      {
        "title": "Home Address",
        "hintText": "Enter your current home address",
        "press": (text) {},
        "controller": addresscontroller
      },
      // {
      //   "title": "Re-type Password",
      //   "hintText": "Enter your Password again",
      //   "press": (text) {},
      //   "controller": passwordagaincontroller,
      //   "type": TextInputType.visiblePassword,
      //   "hide": true,
      // },{
      //   "title": "Re-type Password",
      //   "hintText": "Enter your Password again",
      //   "press": (text) {},
      //   "controller": passwordagaincontroller,
      //   "type": TextInputType.visiblePassword,
      //   "hide": true,
      // },{
      //   "title": "Re-type Password",
      //   "hintText": "Enter your Password again",
      //   "press": (text) {},
      //   "controller": passwordagaincontroller,
      //   "type": TextInputType.visiblePassword,
      //   "hide": true,
      // },
    ];

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            PageDesign(
                sideChild: Container(),
                headerHeight: headerHeight,
                header: SizedBox(
                    height: headerHeight,
                    child: Center(
                      child: Text('My Profile',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400)),
                    )),
                content: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: headerHeight * 0.2),
                      child: MyForm(
                        title: '',
                        details: details,
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
                lastChild: Container(),
                fixedLastChild: MyButton(
                    text: 'Update Profile',
                    press: () async {
                      var errors = validateRegisterFrom(
                        fullnamecontroller.text,
                        emailcontroller.text,
                        phonenumbercontroller.text,
                      );
                      print(errors);
                      if (errors == "") {
                        myprofile.profilepicurl = liveprofile.profilepicurl;
                        myprofile.name = fullnamecontroller.text;
                        myprofile.phonenumber = phonenumbercontroller.text;
                        myprofile.email = emailcontroller.text;
                        myprofile.address = addresscontroller.text;
                        myprofile.updateItem();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Profile updated'),
                          duration: Duration(seconds: 2),
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(errors),
                          duration: const Duration(seconds: 5),
                        ));
                      }
                    })),
            Container(
                margin: EdgeInsets.only(top: headerHeight * 0.75),
                child: ProfileImage(
                    key: Key(context.watch<AuthBloc>().profilepickey ??
                        mee.toString()),
                    image: (liveprofile.profilepicurl == "")
                        ? const AssetImage('assets/images/user.png')
                        : NetworkImage(liveprofile.profilepicurl),
                    press: () {
                      Provider.of<ProfileBloc>(context, listen: false)
                          .changeProfilePic(context);
                    })),
          ],
        ),
      ),
    );
  }

  validateRegisterFrom(
    name,
    emailaddress,
    phonenumber,
  ) {
    //name
    String errors = "";
    if (name.toString().isEmpty) {
      errors += "Name can not be empty \n";
    }
    if (!validateemail(emailaddress)) {
      errors += "Email is invalid \n";
    }
    if (phonenumber.toString().isEmpty) {
      errors += "Phone number can not be empty \n";
    }

    return errors;
  }
}
