import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tej_mart/Features/homescreen.dart';
import 'package:tej_mart/Features/signin.dart';
import 'package:tej_mart/constants/constants.dart';
import 'package:tej_mart/constants/error_handling.dart';
import 'package:tej_mart/models/address_and_amount.dart';
import 'package:tej_mart/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:tej_mart/providers/customer_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:tej_mart/widgets/bottombar.dart';

class UserAuthService {
  //signup user
  Future<String> signUpUser({
    required String email,
    required String name,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserModel user = UserModel(
        id: "",
        name: name,
        email: email,
        password: password,
        mobile_no: "",
        address: "",
        a_balance: 0,
        token: "",
        imageUrl: "",
      );

      http.Response res = await http.post(
        Uri.parse('$url/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandled(
          res: res,
          context: context,
          onSuccess: () {
            showSnackBar(
                context, "Account Create!Login with same credentials.");
            Navigator.pushNamedAndRemoveUntil(
                context, MySignInScreen.routeName, (route) => false);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return "Account created";
  }

  //sign in user
  Future<String> signInUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      var u = Uri.parse('$url/api/signin');
      print(u);
      http.Response res = await http.post(
        Uri.parse('$url/api/signin'),
        body: jsonEncode({"email": email, "password": password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(res.body);
      httpErrorHandled(
          res: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<CustomerProvider>(context, listen: false)
                .setUser(res.body);
            await prefs.setString(
                "x-auth-token", jsonDecode(res.body)['token']);

            Navigator.pushNamedAndRemoveUntil(
                context, MyBottomBar.routeName, (route) => false);
            // showSnackBar(context, "Logged in!");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return "Login";
  }

  Future<AddressAndAmountModel> getUser(
      {required BuildContext context, required String user_id}) async {
    AddressAndAmountModel user =
        AddressAndAmountModel(address: "", mobile_no: "", a_balance: 0.00);
    try {
      http.Response res = await http.get(
        Uri.parse('${url}/api/getUser?user_id=$user_id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandled(
          res: res,
          context: context,
          onSuccess: () {
            Map<String, dynamic> map = jsonDecode(res.body);
            String b = map['a_balance'].toString();
            user = AddressAndAmountModel(
                address: map['address'],
                mobile_no: map['mobile_no'],
                a_balance: double.parse(b));
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return user;
  }
}
