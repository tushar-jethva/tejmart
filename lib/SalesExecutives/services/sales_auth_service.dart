import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:tej_mart/SalesExecutives/features/sales_bottom_bar.dart';
import 'package:tej_mart/SalesExecutives/models/sales_executive.dart';
import 'package:tej_mart/constants/constants.dart';
import 'package:tej_mart/constants/error_handling.dart';
import 'package:tej_mart/providers/salse_user_provider.dart';

class SalesExecutiveAuthServices {
  Future<String> salesSignUpExecutive(
      {required BuildContext context,
      required String name,
      required String email,
      required String password,
      required String shop_name,
      required String mobile_no}) async {
    try {
      SalesExecutive salesExecutive = SalesExecutive(
          id: '',
          name: name,
          email: email,
          password: password,
          shop_name: shop_name,
          mobile_no: mobile_no);

      http.Response res = await http.post(
        Uri.parse('$url/api/salessignup'),
        body: salesExecutive.toJson(),
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
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return "Accoutn Created";
  }

  Future<String> salesSignIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$url/api/salessignin'),
        body: jsonEncode({"email": email, "password": password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandled(
          res: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, "You successfully logged in!");
            var userProvider =
                Provider.of<SalesExecutiveProvider>(context, listen: false);
            userProvider.setUser(res.body);
            Navigator.pushNamedAndRemoveUntil(
                context, MySalesBottomBar.routeName, (route) => false,arguments: {'sales_id':userProvider.user.id});
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return "Logged in";
  }
}
