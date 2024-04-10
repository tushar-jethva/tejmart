// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tej_mart/SalesExecutives/services/sales_prooduct_service.dart';

import '../../constants/colors.dart';
import '../../widgets/custom_button.dart';

class MyOrderBottom extends StatefulWidget {
  final String order_id;
  final String product_id;
  const MyOrderBottom({
    Key? key,
    required this.order_id,
    required this.product_id,
  }) : super(key: key);

  @override
  State<MyOrderBottom> createState() => _MyOrderBottomState();
}

class _MyOrderBottomState extends State<MyOrderBottom> {
  acceptOrder(String order_id, String product_id) async {
    SalesProductService().acceptOrder(
        context: context, order_id: order_id, product_id: product_id);
  }

  declineOrder(String order_id, String product_id) async {
    SalesProductService().declineOrder(
        context: context, order_id: order_id, product_id: product_id);
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
