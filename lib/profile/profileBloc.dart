import 'dart:io';

import 'package:courieradmin/Helpers/filestoragehelper.dart';
import 'package:courieradmin/models/categoriescontainer.dart';
import 'package:courieradmin/models/item.dart';
import 'package:courieradmin/models/profile.dart';
import 'package:courieradmin/signin/myauth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileBloc extends ChangeNotifier {
  changeProfilePic(BuildContext context) async {
    FileStorageHelper fileStorageHelper = FileStorageHelper();
    File image = await fileStorageHelper.getImage();
    //var path = image.path;
    var downloadUrl = await fileStorageHelper.uploadProfilePic(
        image, Provider.of<AuthBloc>(context, listen: false).uid);
    print('Download url is : $downloadUrl');
    Profile myprofile = Provider.of<ProfilesContainer>(context, listen: false)
        .content[0]['item'];
    //did this method twice cos the system isn't recognizing it 
    //cos the url doesn't 
    //seem to be changing
    myprofile.profilepicurl = "";
    myprofile.updateItem();
    myprofile.profilepicurl = downloadUrl;
    myprofile.updateItem();

        //      Future.delayed(const Duration(seconds: 3),()=>Provider.of<AuthBloc>(context, listen: false).setprofilepicurl(""));

        //  Future.delayed(const Duration(seconds: 6),()=>Provider.of<AuthBloc>(context, listen: false).setprofilepicurl(downloadUrl));

  }
}
