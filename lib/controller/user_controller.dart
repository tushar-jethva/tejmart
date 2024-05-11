

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tej_mart/SalesExecutives/models/sales_addProduct.dart';
import 'package:tej_mart/SalesExecutives/services/sales_prooduct_service.dart';
import 'package:tej_mart/services/cart_service.dart';
import 'package:tej_mart/services/favouritescreen.dart';
import 'package:tej_mart/services/product_service.dart';

class UserController extends GetxController {
  RxMap<String, List<dynamic>> list = RxMap();
  RxDouble totalAmount = 0.0.obs;

  RxList<SalesAddProductModel> searchProductsList = RxList();
  final TextEditingController searchController = TextEditingController();

  set setTotalAmount(double val) {
    totalAmount.value = val;
  }

  Future<void> getAllCustomerCartProducts(
      {required String user_id, required BuildContext context}) async {
    Map<String, List<dynamic>>? iList = await CartService()
        .getAllCustomerCartProducts(context: context, user_id: user_id);
    list.value = iList;
    print("products $list");
    print("p ${list['product']!.length}");
  }

  RxList<SalesAddProductModel> fList = RxList();
  Future<void> getAllFavouriteItems(
      {required String user_id, required BuildContext context}) async {
    List<SalesAddProductModel> list = await FavouriteService()
        .getAllWishListProduct(context: context, user_id: user_id);

    fList.value = list;
    print(fList);
  }

  searchProducts() async {
    print("search");
    searchProductsList.clear();
    List<SalesAddProductModel> list = await CustomerProductService()
        .searchProducts(query: searchController.text);
    print(list);
    searchProductsList.value = list;
    print("list is ${searchProductsList}");
  }

  removeWishListItem(
      {required BuildContext context,
      required String productId,
      required String userId}) async{
    await FavouriteService().removeFromWishlist(
        context: context, product_id: productId, user_id: userId);
    getAllFavouriteItems(user_id: userId, context: context);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    print('init');
    super.onInit();
    searchController.addListener(() {
      searchProducts();
    });
  }
}
