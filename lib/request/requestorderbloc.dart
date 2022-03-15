import 'package:courieradmin/models/order.dart';
import 'package:flutter/widgets.dart';

class RequestOrderBloc extends ChangeNotifier {
  Order currentorder = Order();

  Order getCurrentOrder() {
    return currentorder;
  }

  setNewOrder() {
    currentorder = Order();
  }
  
}
