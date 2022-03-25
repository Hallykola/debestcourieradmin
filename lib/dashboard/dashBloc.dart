import 'package:courieradmin/dashboard/dashboard.dart';
import 'package:courieradmin/models/order.dart';
import 'package:courieradmin/models/profile.dart';
import 'package:flutter/material.dart';

import '../models/payment.dart';

class DashBloc extends ChangeNotifier {
  bool detailed = false;
  Order? focusedOrder;
  Profile? focusedUserProfile;
  Profile? focusedRiderProfile;
  Payment? focusedPayment;
  ListType displayOnDash = ListType.ORDERS;
  setDetailed(bool value) {
    detailed = value;
    notifyListeners();
  }

  setFocusedOrder(Order order) {
    focusedOrder = order;
    notifyListeners();
  }

setDisplayOnDash(ListType list) {
    displayOnDash = list;
    notifyListeners();
  }
  setFocusedUserProfile(Profile profile) {
    focusedUserProfile = profile;
    notifyListeners();
  }

  setFocusedRiderProfile(Profile profile) {
    focusedRiderProfile = profile;
    notifyListeners();
  }

  setFocusedPayment(Payment payment) {
    focusedPayment = payment;
    notifyListeners();
  }
}
