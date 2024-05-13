import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tej_mart/models/user_model.dart';

class CustomerProvider with ChangeNotifier {
  UserModel _user = UserModel(
      id: "",
      name: "",
      email: '',
      password: "",
      mobile_no: "",
      address: "",
      a_balance: 0,
      token: "",
      imageUrl: "",
    );

  UserModel get user => _user;

  void setUser(String user) {
    _user = UserModel.fromJson(user);
    notifyListeners();
  }
  
}
