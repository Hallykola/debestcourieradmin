import 'package:courieradmin/Widgets/mybutton.dart';
import 'package:courieradmin/Widgets/myusualbutton.dart';
import 'package:courieradmin/Widgets/pagedesign.dart';
import 'package:courieradmin/constants.dart';
import 'package:courieradmin/main.dart';
import 'package:courieradmin/models/categoriescontainer.dart';
import 'package:courieradmin/models/fcmtoken.dart';
import 'package:courieradmin/signin/myauth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:launch_review/launch_review.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  late bool sharelocation;
  @override
  Widget build(BuildContext context) {
    sharelocation = context.watch<AuthBloc>().sharelocation;
    Size size = MediaQuery.of(context).size;
    double headerHeight = size.height * 0.23;
    return Scaffold(
        bottomNavigationBar: const BottomNav(
          activeTab: 2,
        ),
        backgroundColor: kPrimaryColor,
        body: PageDesign(
          sideChild: Container(),
          headerHeight: headerHeight,
          header: AccountHeader(
            headerHeight: headerHeight,
            press: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          content: Column(
            children: [
              AccountTile(
                  press: () async {
                    String? token = await FirebaseMessaging.instance.getToken();
                    String uid =
                        Provider.of<AuthBloc>(context, listen: false).uid ?? '';
                    Fcmtoken fcmtoken = Fcmtoken();
                    int count = await fcmtoken.getItemsCountWhere('uid', uid);
                    if (count < 1) {
                      fcmtoken.token = token;
                      fcmtoken.uid = uid;
                      fcmtoken.addItem();
                    } else {
                      Fcmtoken item =
                          Provider.of<FcmtokenContainer>(context, listen: false)
                              .content[0]['item'];
                      item.token = token;
                      item.updateItem();
                    }
                  },
                  asset: 'assets/icons/location-pin.svg',
                  title: 'Saved Addresses',
                  text: 'Saved addresses for quick process'),
              AccountTile(
                  active: sharelocation,
                  press: () async {
                    context.read<AuthBloc>().setShareLocation(!sharelocation);
                  },
                  asset: 'assets/icons/globe.svg',
                  title: 'Share Live Location ',
                  text: 'Allow rider/customer to see where you are'),
              AccountTile(
                  press: () async {
                    final Email email = Email(
                      body: 'Email body',
                      subject: 'Email subject',
                      recipients: ['example@example.com'],
                      cc: ['cc@example.com'],
                      bcc: ['bcc@example.com'],
                      //attachmentPaths: ['/path/to/attachment.zip'],
                      isHTML: false,
                    );

                    await FlutterEmailSender.send(email);
                  },
                  asset: 'assets/icons/mail.svg',
                  title: 'Contact us',
                  text: 'Connect us for any query & issue'),
              AccountTile(
                  press: () {
                    Navigator.pushNamed(context, '/termsnconditions');
                  },
                  asset: 'assets/icons/terms-condition.svg',
                  title: 'Terms & Conditions',
                  text: 'Know our Terms & Conditions'),
              AccountTile(
                  press: () {},
                  asset: 'assets/icons/share.svg',
                  title: 'Share App',
                  text: 'Share with friends & family'),
              AccountTile(
                  press: () async {
                    _showMyDialog();
                  },
                  asset: 'assets/icons/logout.svg',
                  title: 'Logout',
                  text: 'Signout from current account'),
              const SizedBox(
                height: 20,
              ),
              MyUsualButton(
                  press: () {
                    LaunchReview.launch();
                  },
                  text: 'RATE US'),
            ],
          ),
          lastChild: Container(),
          fixedLastChild: Container(),
        ));
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Log out'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Do you really want to sign out of your account?'),
                Text('Click yes to leave.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () async {
                Navigator.of(context).pop();
                await Provider.of<AuthBloc>(context,listen:false).userSignout();
                Navigator.pushNamed(context, '/signin');
              },
            ),
          ],
        );
      },
    );
  }
}

class BottomNav extends StatelessWidget {
  const BottomNav({
    Key? key,
    required this.activeTab,
  }) : super(key: key);
  final int activeTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: activeTab,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/deliveries');
          }
          if (index == 1) {
            Navigator.pushNamed(context, '/home');
          }
          if (index == 2) {
            Navigator.pushNamed(context, '/account');
          }
        },
        items: const [
          BottomNavigationBarItem(
              label: 'Deliveries',
              icon: Icon(
                Icons.wallet_membership,
                color: kPrimaryColor,
              )),
          BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(
                Icons.home,
                color: kPrimaryColor,
              )),
          BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(
                Icons.person,
                color: kPrimaryColor,
              )),
        ]);
  }
}

class AccountTile extends StatelessWidget {
  const AccountTile({
    Key? key,
    required this.press,
    required this.asset,
    required this.title,
    required this.text, this.active = false,
  }) : super(key: key);
  final Function() press;
  final String asset;
  final String title;
  final String text;
  final bool active;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      splashColor: kPrimaryColor,
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                  color:active?Colors.green.shade400:Colors.white,
                  shape: BoxShape.circle,
                  ),
                    padding: const EdgeInsets.all(20),
                    child: SvgPicture.asset(asset,
                        height: 25, color: kPrimaryColor)),
                //rSizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w400)),
                    SizedBox(
                      height: 5,
                    ),
                    Text(text,
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey.withOpacity(0.8))),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AccountHeader extends StatelessWidget {
  const AccountHeader({
    Key? key,
    required this.headerHeight,
    required this.press,
  }) : super(key: key);

  final double headerHeight;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: headerHeight,
        child: Container(
          padding: const EdgeInsets.only(top: 25, left: 35, bottom: 20),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Account',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 28),
                ),
                InkWell(
                  splashColor: Colors.white,
                  onTap: press,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                            radius: 36,
                            backgroundImage: NetworkImage(context
                                .watch<ProfilesContainer>()
                                .content[0]['item']
                                .profilepicurl)),
                        const SizedBox(
                          width: 10,
                        ),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text:
                                  '${context.watch<ProfilesContainer>().content[0]['item'].name} \n',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600)),
                          const TextSpan(
                            text: 'View Profile',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )
                        ])),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
