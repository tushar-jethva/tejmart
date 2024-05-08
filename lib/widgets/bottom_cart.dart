// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tej_mart/Features/buyscree.dart';
import 'package:tej_mart/Features/homescreen.dart';
import 'package:tej_mart/constants/colors.dart';
import 'package:tej_mart/constants/constants.dart';
import 'package:tej_mart/constants/style.dart';
import 'package:tej_mart/widgets/custom_button.dart';

class MyBottomCart extends StatefulWidget {
  final double total;
  final int total_items;
  final List<String> products;
  const MyBottomCart(
      {Key? key,
      required this.total,
      required this.total_items,
      required this.products})
      : super(key: key);

  @override
  State<MyBottomCart> createState() => _MyBottomCartState();
}

class _MyBottomCartState extends State<MyBottomCart> {
  openDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Details",
              style: textStyle(),
            ),
            content: Column(
              children: [],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "\$${widget.total.toStringAsFixed(2)}",
                style: GoogleFonts.montserrat().copyWith(
                  color: black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Grand total",
                style: GoogleFonts.montserrat().copyWith(
                  color: Colors.indigo.shade500,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Gap(70),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (widget.total_items > 0) {
                  Navigator.pushNamed(context, MyBuyScreen.routeName,
                      arguments: {
                        "total_items": widget.total_items.toString(),
                        "total": widget.total.toString(),
                        "products": widget.products
                      });
                } else {
                  showSnackBar(context, "Please add items to cart!");
                }
              },
              child: MyCustomButton(
                  color: indigo,
                  name: "Proceed to Buy",
                  textColor: white,
                  borderColor: indigo),
            ),
          ),
        ],
      ),
    );
  }
}
