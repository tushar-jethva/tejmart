import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tej_mart/SalesExecutives/models/sales_addProduct.dart';
import 'package:tej_mart/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:tej_mart/constants/error_handling.dart';
import 'package:tej_mart/providers/customer_provider.dart';
import 'package:tej_mart/widgets/bottombar.dart';

class OrderServices {
  Future<String> addAddressAndMobileNo(
      {required String address,
      required String mobile_no,
      required String user_id,
      required BuildContext context}) async {
    try {
      http.Response res = await http.post(
          Uri.parse('${url}/api/addAddressAndMobile'),
          body: jsonEncode(
              {"address": address, "mobile_no": mobile_no, "user_id": user_id}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      httpErrorHandled(
          res: res,
          context: context,
          onSuccess: () {
            Provider.of<CustomerProvider>(context, listen: false)
                .setUser(res.body);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return "Data update";
  }

  addAmount(
      {required int amount,
      required String user_id,
      required BuildContext context}) async {
    try {
      print("Called");
      http.Response res = await http.post(Uri.parse('${url}/api/addAmount'),
          body: jsonEncode({"amount": amount, "user_id": user_id}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      httpErrorHandled(res: res, context: context, onSuccess: () {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return "Data update";
  }

  Future<String> placeOrder(
      {required BuildContext context,
      required List<String> products,
      required String user_id,
      required double total_amount}) async {
    try {
      http.Response res = await http.post(Uri.parse("$url/api/placeOrder"),
          body: jsonEncode(
            {
              "products": products,
              "user_id": user_id,
              "total_amount": total_amount
            },
          ),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      httpErrorHandled(
          res: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Your order is placed");
            Navigator.pushNamedAndRemoveUntil(
                context, MyBottomBar.routeName, (route) => false);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return "place";
  }

  Future<List<Map<String, dynamic>>> getAllUserOrders(
      {required BuildContext context, required String user_id}) async {
    List<Map<String, dynamic>> listOfProducts = [];
    double total_amount = 0;
    Map<String, dynamic> map = {
      "prouduct": listOfProducts,
      "total_amount": total_amount,
      "orderAt": 0
    };
    try {
      http.Response res = await http.get(
          Uri.parse("$url/api/getAllUserOrders?user_id=$user_id"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      // ignore: use_build_context_synchronously
      httpErrorHandled(
          res: res,
          context: context,
          onSuccess: () {
            var object = jsonDecode(res.body);
            // print(object);
            for (int i = 0; i < object.length; i++) {
              List<Map<String, dynamic>> list = [];

              for (int j = 0; j < object[i]["product"].length; j++) {
                var quantity = object[i]['product'][j]['quantity_product'];
                int status = object[i]['product'][j]['status'];
                dynamic p1 = SalesAddProductModel.fromMap(
                    object[i]['product'][j]['product']);

                Map<String, dynamic> m = {
                  "product": p1,
                  "quantity_product": quantity,
                  "status":status
                };
                list.add(m);
              }
              Map<String, dynamic> map = {
                "product": list,
                "total_amount": object[i]['total_amount'],
                "orderAt": object[i]['orderAt']
              };
              listOfProducts.add(map);
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return listOfProducts;
  }
}
