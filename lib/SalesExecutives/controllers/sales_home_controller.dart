import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tej_mart/SalesExecutives/models/sales_addProduct.dart';
import 'package:tej_mart/SalesExecutives/services/sales_prooduct_service.dart';

class MySalesController extends GetxController {
  RxList<SalesAddProductModel> list = RxList();

  Future<void> getAllProducts(
      {required String sales_id, required BuildContext context}) async {
    print(sales_id);
    List<SalesAddProductModel> iList = await SalesProductService()
        .getAllProducts(context: context, sales_id: sales_id);

    list.value = iList;
    print(list);
  }

  RxList<Map<String, dynamic>> listOfIncomingOrders = RxList();

  getAllSalesProduct(
      {required String sales_id, required BuildContext context}) async {
    List<Map<String, dynamic>>? iList = await SalesProductService()
        .getAllSalesProducts(context: context, seller_id: sales_id);
    print("len i ${iList.length}");
    listOfIncomingOrders.value = iList;
    print("len ${listOfIncomingOrders.length}");
  }
}
