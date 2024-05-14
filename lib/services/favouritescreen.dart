import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tej_mart/SalesExecutives/models/sales_addProduct.dart';
import 'package:tej_mart/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:tej_mart/constants/error_handling.dart';

class FavouriteService {
  Future<String> addToWishlist({
    required BuildContext context,
    required String product_id,
    required String user_id,
  }) async {
    String data = "";
    try {
      http.Response res = await http.post(Uri.parse("$url/api/addToWishlist"),
          body: jsonEncode({"product_id": product_id, "user_id": user_id}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      httpErrorHandled(
          res: res,
          context: context,
          onSuccess: () {
            data = jsonDecode(res.body)['message'];
            showSnackBar(context, data);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return data;
  }

    Future<String> removeFromWishlist({
    required BuildContext context,
    required String product_id,
    required String user_id,
  }) async {
    String data = "";
    try {
      http.Response res = await http.post(Uri.parse("$url/api/deleteWishListProducts"),
          body: jsonEncode({"product_id": product_id, "user_id": user_id}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      httpErrorHandled(
          res: res,
          context: context,
          onSuccess: () {
            data = jsonDecode(res.body)['message'];
            showSnackBar(context, data);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return data;
  }

  Future<List<SalesAddProductModel>> getAllWishListProduct(
      {required BuildContext context, required String user_id}) async {
    List<SalesAddProductModel> list = [];
    try {
      http.Response res = await http.get(
          Uri.parse("$url/api/getWishListProducts?user_id=$user_id"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      print(res.body);

      httpErrorHandled(
          res: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              list.add(SalesAddProductModel.fromMap(jsonDecode(res.body)[i]));
            }
            print(list);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return list;
  }

  
}
