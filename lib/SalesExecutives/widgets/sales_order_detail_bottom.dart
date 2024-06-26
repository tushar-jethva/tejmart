// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tej_mart/SalesExecutives/controllers/sales_home_controller.dart';
import 'package:tej_mart/SalesExecutives/services/sales_prooduct_service.dart';
import 'package:tej_mart/constants/constants.dart';

import '../../constants/colors.dart';
import '../../widgets/custom_button.dart';

class MyOrderBottom extends StatefulWidget {
  final String sales_id;
  final String order_id;
  final String product_id;
  const MyOrderBottom(
      {Key? key,
      required this.order_id,
      required this.product_id,
      required this.sales_id})
      : super(key: key);

  @override
  State<MyOrderBottom> createState() => _MyOrderBottomState();
}

class _MyOrderBottomState extends State<MyOrderBottom> {
  final salesHomeController = Get.put(MySalesController());

  acceptOrder(String order_id, String product_id) async {
    await SalesProductService().acceptOrder(
        context: context, order_id: order_id, product_id: product_id);
    salesHomeController.getAllSalesProduct(
        sales_id: widget.sales_id, context: context);
    showSnackBar(context, "Order accepted!");
  }

  declineOrder(String order_id, String product_id) async {
    await SalesProductService().declineOrder(
        context: context, order_id: order_id, product_id: product_id);
    salesHomeController.getAllSalesProduct(
        sales_id: widget.sales_id, context: context);
    showSnackBar(context, "Order declined!");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                acceptOrder(widget.order_id, widget.product_id);
              },
              child: MyCustomButton(
                  color: green,
                  name: "Accept",
                  textColor: white,
                  borderColor: green),
            ),
          ),
          Gap(5),
          Expanded(
            child: GestureDetector(
              onTap: () {
                declineOrder(widget.order_id, widget.product_id);
              },
              child: MyCustomButton(
                  color: red,
                  name: "Decline",
                  textColor: white,
                  borderColor: red),
            ),
          )
        ],
      ),
    );
  }
}
