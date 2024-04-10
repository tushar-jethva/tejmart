import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tej_mart/Features/cartscreen.dart';
import 'package:tej_mart/SalesExecutives/models/sales_addProduct.dart';
import 'package:tej_mart/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:tej_mart/constants/error_handling.dart';

class CartService {
  Future<String> addToCart({
    required String user_id,
    required String product_id,
    required int quantity_product,
    required BuildContext context,
  }) async {
    try {
      http.Response res = await http.post(
          Uri.parse("${url}/api/addCartProduct"),
          body: jsonEncode({
            "user_id": user_id,
            "product_id": product_id,
            "quantity_product": quantity_product
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      print(res.body);
      httpErrorHandled(
          res: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Your product is added in cart!");

            Navigator.pushNamed(context, MyCartScreen.routeName,
                arguments: {'user_id': user_id});
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return "Cart";
  }

  void incrementQuantity(
      {required BuildContext context, required String product_id}) async {
    try {
      http.Response res = await http.get(
          Uri.parse("${url}/api/incrementQuantity?product_id=${product_id}"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void decrementQuantity(
      {required BuildContext context, required String product_id}) async {
    try {
      http.Response res = await http.get(
          Uri.parse("${url}/api/decrementQuantity?product_id=${product_id}"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<Map<String,List<dynamic>>> getAllCustomerCartProducts({
    required BuildContext context,
    required String user_id,
  }) async {
    List<SalesAddProductModel> products = [];
    var number = [];
    var mainproducts = {"product": products, "quantity": number};
    try {
      http.Response res = await http.get(
          Uri.parse('${url}/api/getAllCustomerCartProducts?user_id=$user_id'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      var a = jsonDecode(res.body);
      httpErrorHandled(
          res: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < a.length; i++) {
              products.add(SalesAddProductModel.fromMap(a[i]['product']));
              number.add(a[i]['quantity_product']);
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return mainproducts;
  }

  Future<String> deleteFromCart(
      {required BuildContext context,
      required String product_id,
      required VoidCallback onSuccess}) async {
    try {
      http.Response res = await http.get(
          Uri.parse('${url}/api/deleteFromCart?product_id=$product_id'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      // ignore: use_build_context_synchronously
      httpErrorHandled(res: res, context: context, onSuccess: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return "Removed";
  }
}
