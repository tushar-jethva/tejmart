import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tej_mart/SalesExecutives/models/sales_addProduct.dart';
import 'package:tej_mart/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:tej_mart/constants/error_handling.dart';

class CustomerProductService {
  Future<List<SalesAddProductModel>> getCategoryWiseProduct(
      {required BuildContext context, required String category}) async {
    List<SalesAddProductModel> categoryProducts = [];
    try {
      http.Response res = await http.get(
          Uri.parse("$url/api/getCategoryProducts?category=$category"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      print(res.body);

      httpErrorHandled(
          res: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              categoryProducts
                  .add(SalesAddProductModel.fromMap(jsonDecode(res.body)[i]));
            }
          });

      print(categoryProducts);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return categoryProducts;
  }

  Future<List<SalesAddProductModel>> getAllSystemProducts(
      {required BuildContext context}) async {
    List<SalesAddProductModel> list = [];
    try {
      http.Response res = await http.get(
          Uri.parse("$url/api/getAllSystemProducts"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      httpErrorHandled(
          res: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              list.add(SalesAddProductModel.fromMap(jsonDecode(res.body)[i]));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return list;
  }
}
