// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:intl/intl.dart';
// import 'package:package_info/package_info.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:the_apple_sign_in/the_apple_sign_in.dart';

// class AuthBloc extends ChangeNotifier {
//   SignInBloc() {
//     checkSignIn();
//     checkGuestUser();
//     initPackageInfo();
//   }

//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   final GoogleSignIn _googlSignIn = new GoogleSignIn();
//   final String defaultUserImageUrl =
//       'https://www.oxfordglobal.co.uk/nextgen-omics-series-us/wp-content/uploads/sites/16/2020/03/Jianming-Xu-e5cb47b9ddeec15f595e7000717da3fe.png';
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;

//   bool _guestUser = false;
//   bool get guestUser => _guestUser;

//   bool _isSignedIn = false;
//   bool get isSignedIn => _isSignedIn;

//   bool _hasError = false;
//   bool get hasError => _hasError;

//   String? _errorCode;
//   String? get errorCode => _errorCode;

//   String? _name;
//   String? get name => _name;

//   String? _uid;
//   String? get uid => _uid;

//   String? _email;
//   String? get email => _email;

//   String? _imageUrl;
//   String? get imageUrl => _imageUrl;

//   String? _signInProvider;
//   String? get signInProvider => _signInProvider;

//   String? timestamp;

//   String _appVersion = '0.0';
//   String get appVersion => _appVersion;

//   String _packageName = '';
//   String get packageName => _packageName;

//   void initPackageInfo() async {
//     PackageInfo packageInfo = await PackageInfo.fromPlatform();
//     _appVersion = packageInfo.version;
//     _packageName = packageInfo.packageName;
//     notifyListeners();
//   }

//   googlesignin() async {
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//     GoogleSignInAuthentication? googleauth = await googleUser?.authentication;
//     final AuthCredential googleAuthCredential = GoogleAuthProvider?.credential(
//       accessToken: googleauth?.accessToken,
//       idToken: googleauth?.idToken,
//     );
//     await _firebaseAuth
//         .signInWithCredential(googleAuthCredential)
//         .then((userCredential) async {
//       print("I work o");
//       //onboardsignin(userCredential);
//     });
//   }

//   Future signInWithGoogle(BuildContext context) async {
//     final GoogleSignInAccount? googleUser = await _googlSignIn.signIn();
//     if (googleUser != null) {
//       try {
//         final GoogleSignInAuthentication googleAuth =
//             await googleUser.authentication;

//         final AuthCredential credential = GoogleAuthProvider.credential(
//           accessToken: googleAuth.accessToken,
//           idToken: googleAuth.idToken,
//         );

//         User userDetails =
//             (await _firebaseAuth.signInWithCredential(credential)).user!;

//         this._name = userDetails.displayName;
//         this._email = userDetails.email;
//         this._imageUrl = userDetails.photoURL;
//         this._uid = userDetails.uid;
//         this._signInProvider = 'google';
//         _isSignedIn = true;

//         _hasError = false;
//         notifyListeners();
//       } catch (e) {
//         _hasError = true;
//         _errorCode = e.toString();
//         notifyListeners();
//       }
//     } else {
//       _hasError = true;
//       notifyListeners();
//     }
//     saveDataToSP();
//   }

//   Future signInwithFacebook() async {
//     User currentUser;
//     final LoginResult facebookLoginResult = await FacebookAuth.instance
//         .login(permissions: ['email', 'public_profile']);
//     if (facebookLoginResult.status == LoginStatus.success) {
//       final _accessToken = await FacebookAuth.instance.accessToken;
//       if (_accessToken != null) {
//         try {
//           final AuthCredential credential =
//               FacebookAuthProvider.credential(_accessToken.token);
//           final User user =
//               (await _firebaseAuth.signInWithCredential(credential)).user!;
//           assert(user.email != null);
//           assert(user.displayName != null);
//           assert(!user.isAnonymous);
//           await user.getIdToken();
//           currentUser = _firebaseAuth.currentUser!;
//           assert(user.uid == currentUser.uid);

//           this._name = user.displayName;
//           this._email = user.email;
//           this._imageUrl = user.photoURL;
//           this._uid = user.uid;
//           this._signInProvider = 'facebook';

//           _hasError = false;
//           notifyListeners();
//         } catch (e) {
//           _hasError = true;
//           _errorCode = e.toString();
//           notifyListeners();
//         }
//       }
//     } else {
//       _hasError = true;
//       _errorCode = 'cancel or error';
//       notifyListeners();
//     }

//     //   User currentUser;
//     //   final FacebookLoginResult facebookLoginResult =  await _fbLogin.logIn(['email', 'public_profile']);
//     //   if(facebookLoginResult.status == FacebookLoginStatus.cancelledByUser){
//     //     _hasError = true;
//     //     _errorCode = 'cancel';
//     //     notifyListeners();
//     //   } else if(facebookLoginResult.status == FacebookLoginStatus.error){
//     //     _hasError = true;
//     //     notifyListeners();
//     //   } else{
//     //     try {
//     //       if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
//     //       FacebookAccessToken facebookAccessToken = facebookLoginResult.accessToken;
//     //       final AuthCredential credential = FacebookAuthProvider.credential(facebookAccessToken.token);
//     //       final User user = (await _firebaseAuth.signInWithCredential(credential)).user;
//     //       assert(user.email != null);
//     //       assert(user.displayName != null);
//     //       assert(!user.isAnonymous);
//     //       assert(await user.getIdToken() != null);
//     //       currentUser = _firebaseAuth.currentUser;
//     //       assert(user.uid == currentUser.uid);

//     //       this._name = user.displayName;
//     //       this._email = user.email;
//     //       this._imageUrl = user.photoURL;
//     //       this._uid = user.uid;
//     //       this._signInProvider = 'facebook';

//     //       _hasError = false;
//     //       notifyListeners();
//     //   }
//     // } catch (e) {
//     //     _hasError = true;
//     //     _errorCode = e.toString();
//     //     notifyListeners();
//     //   }

//     // }
//   }

//   Future signInWithApple() async {
//     final _firebaseAuth = FirebaseAuth.instance;
//     final result = await TheAppleSignIn.performRequests([
//       AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
//     ]);

//     if (result.status == AuthorizationStatus.authorized) {
//       try {
//         final appleIdCredential = result.credential;
//         final oAuthProvider = OAuthProvider('apple.com');
//         final credential = oAuthProvider.credential(
//           idToken: String.fromCharCodes(appleIdCredential!.identityToken!),
//           accessToken:
//               String.fromCharCodes(appleIdCredential.authorizationCode!),
//         );
//         final authResult = await _firebaseAuth.signInWithCredential(credential);
//         final firebaseUser = authResult.user;

//         this._uid = firebaseUser!.uid;
//         this._name =
//             '${appleIdCredential.fullName!.givenName} ${appleIdCredential.fullName!.familyName}';
//         this._email = appleIdCredential.email ?? 'null';
//         this._imageUrl = firebaseUser.photoURL ?? defaultUserImageUrl;
//         this._signInProvider = 'apple';

//         print(firebaseUser);
//         _hasError = false;
//         notifyListeners();
//       } catch (e) {
//         _hasError = true;
//         _errorCode = e.toString();
//         notifyListeners();
//       }
//     } else if (result.status == AuthorizationStatus.error) {
//       _hasError = true;
//       _errorCode = 'Appple Sign In Error! Please try again';
//       notifyListeners();
//     } else if (result.status == AuthorizationStatus.cancelled) {
//       _hasError = true;
//       _errorCode = 'Sign In Cancelled!';
//       notifyListeners();
//     }
//   }

//   Future<bool> signUpwithEmailPassword(
//       userName, userEmail, userPassword) async {
//     try {
//       final User? user = (await _firebaseAuth.createUserWithEmailAndPassword(
//         email: userEmail,
//         password: userPassword,
//       ))
//           .user!;
//       assert(user != null);
//       await user!.getIdToken();
//       this._name = userName;
//       this._uid = user.uid;
//       this._imageUrl = defaultUserImageUrl;
//       this._email = user.email;
//       this._signInProvider = 'email';

//       _hasError = false;
//       notifyListeners();
//       return true;
//     } catch (e) {
//       _hasError = true;
//       _errorCode = e.toString();
//       notifyListeners();
//       return false;
//     }
//   }

//   Future<bool> signInwithEmailPassword(userEmail, userPassword) async {
//     try {
//       final User? user = (await _firebaseAuth.signInWithEmailAndPassword(
//               email: userEmail, password: userPassword))
//           .user!;
//       assert(user != null);
//       await user!.getIdToken();
//       final User currentUser = _firebaseAuth.currentUser!;
//       this._uid = currentUser.uid;
//       this._signInProvider = 'email';
//       //print(user.email);
//       _hasError = false;
//       notifyListeners();
//       return true;
//     } catch (e) {
//       _hasError = true;
//       _errorCode = e.toString();
//       print(_errorCode);
//       notifyListeners();
//       return false;
//     }
//   }

//   Future<bool> checkUserExists() async {
//     DocumentSnapshot snap = await firestore.collection('users').doc(_uid).get();
//     if (snap.exists) {
//       print('User Exists');
//       return true;
//     } else {
//       print('new user');
//       return false;
//     }
//   }

//   Future saveToFirebase() async {
//     final DocumentReference ref =
//         FirebaseFirestore.instance.collection('users').doc(_uid);
//     var userData = {
//       'name': _name,
//       'email': _email,
//       'uid': _uid,
//       'image url': _imageUrl,
//       'timestamp': timestamp,
//       'loved items': [],
//       'bookmarked items': []
//     };
//     await ref.set(userData);
//   }

//   Future getTimestamp() async {
//     DateTime now = DateTime.now();
//     String _timestamp = DateFormat('yyyyMMddHHmmss').format(now);
//     timestamp = _timestamp;
//   }

//   Future saveDataToSP() async {
//     final SharedPreferences sp = await SharedPreferences.getInstance();

//     await sp.setString('name', _name!);
//     await sp.setString('email', _email!);
//     await sp.setString('image_url', _imageUrl!);
//     await sp.setString('uid', _uid!);
//     await sp.setString('sign_in_provider', _signInProvider!);
//   }

//   Future getDataFromSp() async {
//     final SharedPreferences sp = await SharedPreferences.getInstance();
//     _name = sp.getString('name');
//     _email = sp.getString('email');
//     _imageUrl = sp.getString('image_url');
//     _uid = sp.getString('uid');
//     _signInProvider = sp.getString('sign_in_provider');
//     notifyListeners();
//   }

//   Future getUserDatafromFirebase(uid) async {
//     await FirebaseFirestore.instance
//         .collection('users')
//         .doc(uid)
//         .get()
//         .then((DocumentSnapshot snap) {
//       this._uid = snap['uid'];
//       this._name = snap['name'];
//       this._email = snap['email'];
//       this._imageUrl = snap['image url'];
//       print(_name);
//     });
//     notifyListeners();
//   }

//   Future setSignIn() async {
//     final SharedPreferences sp = await SharedPreferences.getInstance();
//     sp.setBool('signed_in', true);
//     _isSignedIn = true;
//     notifyListeners();
//   }

//   void checkSignIn() async {
//     final SharedPreferences sp = await SharedPreferences.getInstance();
//     _isSignedIn = sp.getBool('signed_in') ?? false;
//     notifyListeners();
//   }

//   Future userSignout() async {
//     if (_signInProvider == 'apple') {
//       await _firebaseAuth.signOut();
//     } else if (_signInProvider == 'facebook') {
//       await _firebaseAuth.signOut();
//       // await _fbLogin.logOut();
//     } else if (_signInProvider == 'email') {
//       await _firebaseAuth.signOut();
//     } else {
//       await _firebaseAuth.signOut();
//       await _googlSignIn.signOut();
//     }
//     _name = "";
//     print(_name);
//     notifyListeners();
//     // afterUserSignOut();
//   }

//   Future afterUserSignOut() async {
//     await userSignout().then((value) async {
//       await clearAllData();
//       _isSignedIn = false;
//       _guestUser = false;
//       notifyListeners();
//     });
//   }

//   Future setGuestUser() async {
//     final SharedPreferences sp = await SharedPreferences.getInstance();
//     await sp.setBool('guest_user', true);
//     _guestUser = true;
//     notifyListeners();
//   }

//   void checkGuestUser() async {
//     final SharedPreferences sp = await SharedPreferences.getInstance();
//     _guestUser = sp.getBool('guest_user') ?? false;
//     notifyListeners();
//   }

//   Future clearAllData() async {
//     final SharedPreferences sp = await SharedPreferences.getInstance();
//     sp.clear();
//   }

//   Future guestSignout() async {
//     final SharedPreferences sp = await SharedPreferences.getInstance();
//     await sp.setBool('guest_user', false);
//     _guestUser = false;
//     notifyListeners();
//   }

//   Future updateUserProfile(String newName, String newImageUrl) async {
//     final SharedPreferences sp = await SharedPreferences.getInstance();

//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(_uid)
//         .update({'name': newName, 'image url': newImageUrl});

//     sp.setString('name', newName);
//     sp.setString('image_url', newImageUrl);
//     _name = newName;
//     _imageUrl = newImageUrl;

//     notifyListeners();
//   }

//   Future<int> getTotalUsersCount() async {
//     final String fieldName = 'count';
//     final DocumentReference ref =
//         firestore.collection('item_count').doc('users_count');
//     DocumentSnapshot snap = await ref.get();
//     if (snap.exists == true) {
//       int itemCount = snap[fieldName] ?? 0;
//       return itemCount;
//     } else {
//       await ref.set({fieldName: 0});
//       return 0;
//     }
//   }

//   Future increaseUserCount() async {
//     await getTotalUsersCount().then((int documentCount) async {
//       await firestore
//           .collection('item_count')
//           .doc('users_count')
//           .update({'count': documentCount + 1});
//     });
//   }
// }

import 'dart:async';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courieradmin/models/categoriescontainer.dart';
import 'package:courieradmin/models/fcmtoken.dart';
import 'package:courieradmin/models/order.dart';
import 'package:courieradmin/models/payment.dart';
import 'package:courieradmin/models/profile.dart';
import 'package:courieradmin/payments/payments.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';
import 'package:location/location.dart';

class AuthBloc extends ChangeNotifier {
  SignInBloc() {
    checkSignIn();
    checkGuestUser();
    initPackageInfo();
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googlSignIn = new GoogleSignIn();
  final String defaultUserImageUrl =
      'https://www.oxfordglobal.co.uk/nextgen-omics-series-us/wp-content/uploads/sites/16/2020/03/Jianming-Xu-e5cb47b9ddeec15f595e7000717da3fe.png';
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Profile userprofile = Profile();
  bool sharelocation = false;
  var profilepicurl;
  var profilepickey;
  bool _guestUser = false;
  bool get guestUser => _guestUser;

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  bool _hasError = false;
  bool get hasError => _hasError;

  String? _errorCode;
  String? get errorCode => _errorCode;

  String? _name;
  String? get name => _name;

  String? phonenumber;

  String? _uid;
  String? get uid => _uid;

  String? _email;
  String? get email => _email;

  String? _imageUrl;
  String? get imageUrl => _imageUrl;

  String? _signInProvider;
  String? get signInProvider => _signInProvider;

  String? timestamp;

  String _appVersion = '0.0';
  String get appVersion => _appVersion;

  String _packageName = '';
  String get packageName => _packageName;

  setShareLocation(bool share) {
    sharelocation = share;
    notifyListeners();
  }

  void initPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _appVersion = packageInfo.version;
    _packageName = packageInfo.packageName;
    notifyListeners();
  }

  googlesignin() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleauth = await googleUser?.authentication;
    final AuthCredential googleAuthCredential = GoogleAuthProvider?.credential(
      accessToken: googleauth?.accessToken,
      idToken: googleauth?.idToken,
    );
    await _firebaseAuth
        .signInWithCredential(googleAuthCredential)
        .then((userCredential) async {
      print("I work o");
      //onboardsignin(userCredential);
    });
  }

  Future signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await _googlSignIn.signIn();
    if (googleUser != null) {
      try {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        User userDetails =
            (await _firebaseAuth.signInWithCredential(credential)).user!;

        this._name = userDetails.displayName;
        this._email = userDetails.email;
        this._imageUrl = userDetails.photoURL;
        this._uid = userDetails.uid;
        this._signInProvider = 'google';
        _isSignedIn = true;

        _hasError = false;
        notifyListeners();
        fetchProfile();
        getAllDeliveries(context);
        getAllPayments(context);
        getDeviceTokenInAdvance(context);
        // won't get upated valuess from the work of fetch profile immediately
        //because fetch profile is async and it effects will show later and the line below will be updated
        //because it is an open stream
        userprofile.getItemsWhere(
            Provider.of<ProfilesContainer>(context, listen: false), "uid", uid);
      } catch (e) {
        _hasError = true;
        _errorCode = e.toString();
        notifyListeners();
      }
    } else {
      _hasError = true;
      notifyListeners();
    }
    saveDataToSP();
  }

  Future signInwithFacebook() async {
    User currentUser;
    final LoginResult facebookLoginResult = await FacebookAuth.instance
        .login(permissions: ['email', 'public_profile']);
    if (facebookLoginResult.status == LoginStatus.success) {
      final _accessToken = await FacebookAuth.instance.accessToken;
      if (_accessToken != null) {
        try {
          final AuthCredential credential =
              FacebookAuthProvider.credential(_accessToken.token);
          final User user =
              (await _firebaseAuth.signInWithCredential(credential)).user!;
          assert(user.email != null);
          assert(user.displayName != null);
          assert(!user.isAnonymous);
          await user.getIdToken();
          currentUser = _firebaseAuth.currentUser!;
          assert(user.uid == currentUser.uid);

          this._name = user.displayName;
          this._email = user.email;
          this._imageUrl = user.photoURL;
          this._uid = user.uid;
          this._signInProvider = 'facebook';

          _hasError = false;
          notifyListeners();
        } catch (e) {
          _hasError = true;
          _errorCode = e.toString();
          notifyListeners();
        }
      }
    } else {
      _hasError = true;
      _errorCode = 'cancel or error';
      notifyListeners();
    }

    //   User currentUser;
    //   final FacebookLoginResult facebookLoginResult =  await _fbLogin.logIn(['email', 'public_profile']);
    //   if(facebookLoginResult.status == FacebookLoginStatus.cancelledByUser){
    //     _hasError = true;
    //     _errorCode = 'cancel';
    //     notifyListeners();
    //   } else if(facebookLoginResult.status == FacebookLoginStatus.error){
    //     _hasError = true;
    //     notifyListeners();
    //   } else{
    //     try {
    //       if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
    //       FacebookAccessToken facebookAccessToken = facebookLoginResult.accessToken;
    //       final AuthCredential credential = FacebookAuthProvider.credential(facebookAccessToken.token);
    //       final User user = (await _firebaseAuth.signInWithCredential(credential)).user;
    //       assert(user.email != null);
    //       assert(user.displayName != null);
    //       assert(!user.isAnonymous);
    //       assert(await user.getIdToken() != null);
    //       currentUser = _firebaseAuth.currentUser;
    //       assert(user.uid == currentUser.uid);

    //       this._name = user.displayName;
    //       this._email = user.email;
    //       this._imageUrl = user.photoURL;
    //       this._uid = user.uid;
    //       this._signInProvider = 'facebook';

    //       _hasError = false;
    //       notifyListeners();
    //   }
    // } catch (e) {
    //     _hasError = true;
    //     _errorCode = e.toString();
    //     notifyListeners();
    //   }

    // }
  }

  Future signInWithApple() async {
    final _firebaseAuth = FirebaseAuth.instance;
    final result = await TheAppleSignIn.performRequests([
      AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);

    if (result.status == AuthorizationStatus.authorized) {
      try {
        final appleIdCredential = result.credential;
        final oAuthProvider = OAuthProvider('apple.com');
        final credential = oAuthProvider.credential(
          idToken: String.fromCharCodes(appleIdCredential!.identityToken!),
          accessToken:
              String.fromCharCodes(appleIdCredential.authorizationCode!),
        );
        final authResult = await _firebaseAuth.signInWithCredential(credential);
        final firebaseUser = authResult.user;

        this._uid = firebaseUser!.uid;
        this._name =
            '${appleIdCredential.fullName!.givenName} ${appleIdCredential.fullName!.familyName}';
        this._email = appleIdCredential.email ?? 'null';
        this._imageUrl = firebaseUser.photoURL ?? defaultUserImageUrl;
        this._signInProvider = 'apple';

        print(firebaseUser);
        _hasError = false;
        notifyListeners();
      } catch (e) {
        _hasError = true;
        _errorCode = e.toString();
        notifyListeners();
      }
    } else if (result.status == AuthorizationStatus.error) {
      _hasError = true;
      _errorCode = 'Appple Sign In Error! Please try again';
      notifyListeners();
    } else if (result.status == AuthorizationStatus.cancelled) {
      _hasError = true;
      _errorCode = 'Sign In Cancelled!';
      notifyListeners();
    }
  }

  Future<bool> signUpwithEmailPassword(
      userName, userEmail, userPassword, context) async {
    try {
      final User? user = (await _firebaseAuth.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      ))
          .user!;
      assert(user != null);
      await user!.getIdToken();
      this._name = userName;
      this._uid = user.uid;
      this._imageUrl = defaultUserImageUrl;
      this._email = user.email;
      this._signInProvider = 'email';

      _hasError = false;

      userprofile.name = userName;
      userprofile.address = 'Nigeria';
      userprofile.uid = user.uid;
      userprofile.addItem();

      notifyListeners();
      fetchProfile();
      getAllDeliveries(context);
      getAllPayments(context);
      getDeviceTokenInAdvance(context);
      // won't get upated valuess from the work of fetch profile immediately
      //because fetch profile is async and it effects will show later and the line below will be updated
      //because it is an open stream
      userprofile.getItemsWhere(
          Provider.of<ProfilesContainer>(context, listen: false), "uid", uid);
      return true;
    } catch (e) {
      _hasError = true;
      _errorCode = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> signInwithEmailPassword(context, userEmail, userPassword) async {
    try {
      final User? user = (await _firebaseAuth.signInWithEmailAndPassword(
              email: userEmail, password: userPassword))
          .user!;
      assert(user != null);
      await user!.getIdToken();
      final User currentUser = _firebaseAuth.currentUser!;
      this._uid = currentUser.uid;
      this._signInProvider = 'email';
      //print(user.email);
      _hasError = false;
      notifyListeners();
      fetchProfile();
      getAllDeliveries(context);
      getAllPayments(context);
      getDeviceTokenInAdvance(context);
      // won't get upated valuess from the work of fetch profile immediately
      //because fetch profile is async and it effects will show later and the line below will be updated
      //because it is an open stream
      userprofile.getItemsWhere(
          Provider.of<ProfilesContainer>(context, listen: false), "uid", uid);

      return true;
    } catch (e) {
      _hasError = true;
      _errorCode = e.toString();
      print(_errorCode);
      notifyListeners();
      return false;
    }
  }

  Future<bool> checkUserExists() async {
    DocumentSnapshot snap = await firestore.collection('users').doc(_uid).get();
    if (snap.exists) {
      print('User Exists');
      return true;
    } else {
      print('new user');
      return false;
    }
  }

  Future saveToFirebase() async {
    final DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(_uid);
    var userData = {
      'name': _name,
      'email': _email,
      'uid': _uid,
      'image url': _imageUrl,
      'timestamp': timestamp,
      'loved items': [],
      'bookmarked items': []
    };
    await ref.set(userData);
  }

  Future getTimestamp() async {
    DateTime now = DateTime.now();
    String _timestamp = DateFormat('yyyyMMddHHmmss').format(now);
    timestamp = _timestamp;
  }

  Future saveDataToSP() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();

    await sp.setString('name', _name!);
    await sp.setString('email', _email!);
    await sp.setString('image_url', _imageUrl!);
    await sp.setString('uid', _uid!);
    await sp.setString('sign_in_provider', _signInProvider!);
  }

  Future getDataFromSp() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _name = sp.getString('name');
    _email = sp.getString('email');
    _imageUrl = sp.getString('image_url');
    _uid = sp.getString('uid');
    _signInProvider = sp.getString('sign_in_provider');
    notifyListeners();
  }

  Future getUserDatafromFirebase(uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot snap) {
      this._uid = snap['uid'];
      this._name = snap['name'];
      this._email = snap['email'];
      this._imageUrl = snap['image url'];
      print(_name);
    });
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool('signed_in', true);
    _isSignedIn = true;
    notifyListeners();
  }

  fetchProfile() async {
    int count = await userprofile.getItemsCountWhere("uid", uid);
    print("I fetched profile and count is: $count");
    if (count == 0) {
      userprofile.name = name ?? 'New User';
      userprofile.uid = uid ?? '';
      userprofile.email = email ?? '';
      userprofile.phonenumber = phonenumber ?? '';
      userprofile.address = "Nigeria";
      // userprofile.name = name!;
      userprofile.addItem();
    }
  }

  void checkSignIn() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _isSignedIn = sp.getBool('signed_in') ?? false;
    notifyListeners();
  }

  Future userSignout() async {
    if (_signInProvider == 'apple') {
      await _firebaseAuth.signOut();
    } else if (_signInProvider == 'facebook') {
      await _firebaseAuth.signOut();
      // await _fbLogin.logOut();
    } else if (_signInProvider == 'email') {
      await _firebaseAuth.signOut();
    } else {
      await _firebaseAuth.signOut();
      await _googlSignIn.signOut();
    }
    _name = "";
    print(_name);
    _isSignedIn = false;
    notifyListeners();
    // afterUserSignOut();
  }

  Future afterUserSignOut() async {
    await userSignout().then((value) async {
      await clearAllData();
      _isSignedIn = false;
      _guestUser = false;
      notifyListeners();
    });
  }

  Future setGuestUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setBool('guest_user', true);
    _guestUser = true;
    notifyListeners();
  }

  void checkGuestUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _guestUser = sp.getBool('guest_user') ?? false;
    notifyListeners();
  }

  Future clearAllData() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
  }

  Future guestSignout() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setBool('guest_user', false);
    _guestUser = false;
    notifyListeners();
  }

  Future updateUserProfile(String newName, String newImageUrl) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();

    FirebaseFirestore.instance
        .collection('users')
        .doc(_uid)
        .update({'name': newName, 'image url': newImageUrl});

    sp.setString('name', newName);
    sp.setString('image_url', newImageUrl);
    _name = newName;
    _imageUrl = newImageUrl;

    notifyListeners();
  }

  Future<int> getTotalUsersCount() async {
    final String fieldName = 'count';
    final DocumentReference ref =
        firestore.collection('item_count').doc('users_count');
    DocumentSnapshot snap = await ref.get();
    if (snap.exists == true) {
      int itemCount = snap[fieldName] ?? 0;
      return itemCount;
    } else {
      await ref.set({fieldName: 0});
      return 0;
    }
  }

  Future increaseUserCount() async {
    await getTotalUsersCount().then((int documentCount) async {
      await firestore
          .collection('item_count')
          .doc('users_count')
          .update({'count': documentCount + 1});
    });
  }

  void setprofilepicurl(downloadUrl) {
    profilepicurl = downloadUrl;
    profilepickey = DateTime.now().millisecondsSinceEpoch.toString();
    Timer.periodic(const Duration(seconds: 6), (timer) {
      timer.cancel();
    });
    notifyListeners();
  }

  getAllDeliveries(context) {
    Order order = Order();
    order.getItems(
      Provider.of<DeliveriesContainer>(context, listen: false),
    );

    // order.getItemsWhere(
    //     Provider.of<DeliveriesContainer>(context, listen: false),
    //     'rideruid',
    //     Provider.of<AuthBloc>(context, listen: false).uid);
  }

  getAllPayments(context) {
    Payment payments = Payment();
    payments.getItemsWhere(
        Provider.of<PaymentsContainer>(context, listen: false),
        'owneruid',
        Provider.of<AuthBloc>(context, listen: false).uid);
  }

  getDeviceTokenInAdvance(context) {
    Fcmtoken fcmtoken = Fcmtoken();
    //fcmtoken.setref('fcmtokens/$uid');
    FcmtokenContainer container =
        Provider.of<FcmtokenContainer>(context, listen: false);
    fcmtoken.getItemsWhere(
        Provider.of<FcmtokenContainer>(context, listen: false), 'uid', uid);
  }
}
