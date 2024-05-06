import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tej_mart/services/cart_service.dart';

class UserController extends GetxController {
  RxMap<String, List<dynamic>> list = RxMap();
  RxDouble totalAmount = 0.0.obs;

  set setTotalAmount(double val) {
    totalAmount.value = val;
  }

  Future<void> getAllCustomerCartProducts(
      {required String user_id, required BuildContext context}) async {
    Map<String, List<dynamic>>? iList = await CartService()
        .getAllCustomerCartProducts(context: context, user_id: user_id);

    list.value = iList;
    print(list);
  }
}
