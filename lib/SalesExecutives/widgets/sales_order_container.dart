// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:tej_mart/constants/colors.dart';
import 'package:tej_mart/constants/images_link.dart';

import '../../constants/style.dart';

class MySalesOrderContainer extends StatelessWidget {
  Map<String, dynamic> map;
  MySalesOrderContainer({
    Key? key,
    required this.map,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(map);
    return Container(
      width: 200,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: lightGrey,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: CachedNetworkImageProvider(map['product'].images[0]),
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
                "Total Items: ${map['quantity_product']}",
                style: textStyle()
                    .copyWith(color: white, overflow: TextOverflow.ellipsis),
                maxLines: 2,
              ),
              // Text(
              //   "${product['total_amount'].toString()}\$",
              //   style: textStyle().copyWith(color: white),
              // ),
              // Text(
              //   "${d12.toString()}",
              //   style: textStyle().copyWith(color: white),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
