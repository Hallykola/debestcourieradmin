import 'package:flutter/services.dart';

validateemail(email) {
    bool emailValid =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);

    return emailValid;
  }

   getBytes(filelocation) async {
        ByteData bytes =
            await rootBundle.load(filelocation);
       return  bytes;
      }