// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:tej_mart/SalesExecutives/models/sales_addProduct.dart';
import 'package:tej_mart/constants/colors.dart';
import 'package:tej_mart/constants/images_link.dart';
import 'package:tej_mart/constants/style.dart';
import 'package:intl/intl.dart';

class MyOrderContainer extends StatelessWidget {
  Map<String, dynamic> product;
  MyOrderContainer({
    Key? key,
    required this.product,
  }) : super(key: key);

  List<SalesAddProductModel> products = [];

  @override
  Widget build(BuildContext context) {
    var dateAndTime = DateTime.fromMillisecondsSinceEpoch(product['orderAt']);
    int quantity = 0;
   
    var d12 = DateFormat('dd/MM/yyyy').format(dateAndTime);
    for (int i = 0; i < product['product'].length; i++) {
      products.add(product['product'][i]['product']);
      String s = product['product'][i]['quantity_product'].toString();
      quantity += int.parse(s);
    }
    return Container(
      width: 200,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: lightGrey,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: CachedNetworkImageProvider(products[0].images[0]),
              fit: BoxFit.cover)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
              Colors.black.withOpacity(0.8),
              Colors.black.withOpacity(0.1),
            ])),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Total Items: ${quantity}",
                style: textStyle()
                    .copyWith(color: white, overflow: TextOverflow.ellipsis),
                maxLines: 2,
              ),
              Text(
                "${product['total_amount'].toString()}\$",
                style: textStyle().copyWith(color: white),
              ),
              Text(
                "${d12.toString()}",
                style: textStyle().copyWith(color: white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
