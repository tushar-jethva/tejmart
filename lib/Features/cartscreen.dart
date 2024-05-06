// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tej_mart/Features/details_screen.dart';

import 'package:tej_mart/SalesExecutives/models/sales_addProduct.dart';
import 'package:tej_mart/constants/style.dart';
import 'package:tej_mart/controller/user_controller.dart';
import 'package:tej_mart/providers/cart_provider.dart';
import 'package:tej_mart/providers/customer_provider.dart';
import 'package:tej_mart/services/cart_service.dart';
import 'package:tej_mart/widgets/bottom_cart.dart';
import 'package:tej_mart/widgets/bottombar.dart';
import 'package:tej_mart/widgets/cart_item.dart';
import 'package:tej_mart/widgets/loader.dart';

import '../constants/colors.dart';

class MyCartScreen extends StatefulWidget {
  static const routeName = "/cartScreen";
  final Map<String, String> map;
  const MyCartScreen({
    Key? key,
    required this.map,
  }) : super(key: key);

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  final userController = Get.put(UserController());

  @override
  void initState() {
    // TODO: implement initState
    // getAllCustomerCartProducts();
    userController.getAllCustomerCartProducts(
        user_id: widget.map['user_id']!, context: context);
  }

  List<Color> colors = [
    Colors.red.shade100,
    Colors.yellow.shade100,
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.cyan.shade100,
  ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomerProvider>(context, listen: false).user;
    int total_items = 0;
    List<String> products = [];

    return Obx(() {
      if (userController.list.isNotEmpty &&
          userController.list['product'] != null) {
        double total = 0;
        total_items = userController.list!['product']!.length;
        for (int i = 0; i < userController.list!['product']!.length; i++) {
          SalesAddProductModel product = userController.list!['product']![i];
          products.add(product.id);
          double disPrice = product.price * (1 - (product.discount / 100.00));
          total += disPrice * userController.list!['quantity']![i];
        }

        userController.setTotalAmount = total;
        print("total items ${userController.totalAmount}");
      }
      return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_new)),
          title: Text(
            "Cart",
            style: textStyle(),
          ),
        ),
        body: userController.list.isEmpty &&
                userController.list['product'] == null
            ? Center(
                child: Text("Please add something!"),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: userController.list['product']!.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          SalesAddProductModel product =
                              userController.list!['product']![index];
                          double discountedPrice =
                              product.price * (1 - (product.discount / 100.00));
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, MyDetailsScreen.routeName,
                                  arguments: {
                                    "name": product.category,
                                    "product": product
                                  });
                            },
                            child: MyOneCartItem(
                              user_id: widget.map["user_id"]!,
                              id: product.id,
                              itemName: product.name,
                              shopName: product.shop_name,
                              disPrice: discountedPrice,
                              oriPrice: product.price,
                              discount: product.discount,
                              image: product.images[0],
                              color: lightGrey,
                              quantity: userController.list['quantity']![index],
                            ),
                          );
                        }),
                  ),
                ],
              ),
        bottomNavigationBar: MyBottomCart(
          total: userController.totalAmount.value,
          total_items: total_items,
          products: products,
        ),
      );
    });
  }
}
