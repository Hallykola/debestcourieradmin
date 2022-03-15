import 'package:courieradmin/models/categoriescontainer.dart';
import 'package:courieradmin/models/itemscontainer.dart';
import 'package:courieradmin/models/profile.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class UtilBloc extends ChangeNotifier {
  getProfile(uid, context) async {
    Profile profile = Profile();
    profile.baseref = 'profiles';
    ItemsContainer aprofileContainer = ProfilesContainer();
    print('i wan get');
    await profile.getItemsWhere(
        Provider.of<OtherProfilesContainer>(context, listen: false),
        'uid',
        uid);
    await Future.delayed(const Duration(seconds: 3), () {});
    print('Container length is:${aprofileContainer.content.length}');
  }
}
