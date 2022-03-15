import 'package:courieradmin/models/address.dart';
import 'package:courieradmin/models/categoriescontainer.dart';
import 'package:courieradmin/signin/myauth.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class SavedAddressBloc extends ChangeNotifier {
  getMySavedAddresses(BuildContext context) {
    PlaceAddress placeAddress = PlaceAddress();
    SavedAddressContainer savedAddressContainer = Provider.of<SavedAddressContainer>(context,listen:false);
    placeAddress.getItemsWhere(savedAddressContainer, 'owner', Provider.of<AuthBloc>(context,listen:false).uid);
  }
}
