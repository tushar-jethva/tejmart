import 'package:flutter/material.dart';
import 'package:tej_mart/SalesExecutives/models/sales_executive.dart';

class SalesExecutiveProvider with ChangeNotifier {
  SalesExecutive _user = SalesExecutive(
    id:"",
      name: "", email: "", password: "", shop_name: "", mobile_no: "");
  SalesExecutive get user => _user;

  void setUser(String user) {
    _user = SalesExecutive.fromJson(user);
    notifyListeners();
  }
}
