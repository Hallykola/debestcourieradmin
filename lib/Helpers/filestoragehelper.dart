import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FileStorageHelper {
  //FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<dynamic> getImage() async {
    ImagePicker imagePicker = ImagePicker();
    var image = await imagePicker.pickImage(source: ImageSource.gallery);
    File croppedImage = await cropImage(image);
    return croppedImage;
  }

  Future<File> cropImage(imageFile) async {
    ImageCropper cropper = ImageCropper();
    File? croppedFile = await cropper.cropImage(
        sourcePath: imageFile.path,
        compressQuality: 50,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    return croppedFile!;
  }

  Future uploadProfilePic(image, uid) async {
    String folderName = uid;
    var timeStamp = DateTime.now().millisecondsSinceEpoch;
    print('i wan upload');
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref('profiles/$uid');
    UploadTask uploadTask = firebaseStorageRef.putFile(image);
    await Future.delayed(const Duration(seconds: 3), (){});
    TaskSnapshot taskSnapshot = uploadTask.snapshot;
    return taskSnapshot.ref.getDownloadURL();
  }

  // Future deleteProfilePicFolder(name) async {
  //   String folderName = name;
  //   //File file = File(path);
  //   Reference firebaseStorageRef =
  //       FirebaseStorage.instance.ref('profiles/').child(folderName);
  //   try {
  //     firebaseStorageRef.delete();
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //   return true;
  // }
}
