// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:tej_mart/constants/colors.dart';
import 'package:tej_mart/constants/images_link.dart';
import 'package:tej_mart/constants/style.dart';

class MySignleOrderDetailsContainer extends StatelessWidget {
  final String name;
  final String price;
  final String image;
  final int quantity;
  final int status;
  const MySignleOrderDetailsContainer(
      {Key? key,
      required this.name,
      required this.price,
      required this.image,
      required this.quantity,
      required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: lightGrey),
      child: Row(
        children: [
          Container(
            height: 130,
            width: 130,
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: CachedNetworkImageProvider(image),
                    fit: BoxFit.cover)),
          ),
          Gap(10),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "$name",
                  style: textStyle(),
                ),
                Text(
                  "$price",
                  style: textStyle(),
                ),
                Text(
                  "Quantity: $quantity",
                  style: textStyle(),
                ),
                status == 0
                    ? Row(
                        children: [
                          Text("Status: "),
                          Text(
                            "Pending",
                            style: textStyle().copyWith(color: Colors.blue),
                          )
                        ],
                      )
                    : status == 1
                        ? Row(
                            children: [
                              Text("Status: "),
                              Text(
                                "Completed",
                                style:
                                    textStyle().copyWith(color: Colors.green),
                              )
                            ],
                          )
                        : Row(
                            children: [
                              Text("Status: "),
                              Text(
                                "Denied",
                                style: textStyle().copyWith(color: Colors.red),
                              )
                            ],
                          )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
