import 'dart:convert';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:tej_mart/SalesExecutives/models/sales_addProduct.dart';
import 'package:tej_mart/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:tej_mart/constants/error_handling.dart';
import 'package:image_picker/image_picker.dart';

class SalesProductService {
  Future<String> addProduct({
    required BuildContext context,
    required String sales_id,
    required String description,
    required String name,
    required int price,
    required int discount,
    required int quantity,
    required String category,
    required List<XFile?> images,
    required String shop_name,
    required VoidCallback onSuccess,
  }) async {
    try {
      final clodinary = CloudinaryPublic('diarrqynw', 'tgqozbcc');
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await clodinary
            .uploadFile(CloudinaryFile.fromFile(images[i]!.path, folder: name));
        imageUrls.add(res.secureUrl);
      }

      SalesAddProductModel salesAddProductModel = SalesAddProductModel(
          description: description,
          sales_id: sales_id,
          shop_name: shop_name,
          id: '',
          name: name,
          price: price,
          discount: discount,
          quantity: quantity,
          category: category,
          images: imageUrls);
      http.Response res = await http.post(Uri.parse("$url/api/addProduct"),
          body: salesAddProductModel.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      httpErrorHandled(res: res, context: context, onSuccess: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return "Added Product!";
  }

  Future<List<SalesAddProductModel>> getAllProducts({
    required BuildContext context,
    required String sales_id,
  }) async {
    List<SalesAddProductModel> list = [];
    try {
      http.Response res = await http.get(
          Uri.parse('$url/api/getAllProducts?id=$sales_id'),
          headers: <String, String>{
            'Content-Type': 'application/json charset=UTF-8',
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

  Future<String> deleleProduct({
    required BuildContext context,
    required String product_id,
  }) async {
    try {
      http.Response res = await http.post(Uri.parse("$url/api/deleteProduct"),
          body: jsonEncode({'product_id': product_id}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      httpErrorHandled(
          res: res,
          context: context,
          onSuccess: () {
            Navigator.pop(context);
            showSnackBar(context, "Product is deleted");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return "Product is deleted!";
  }
}
