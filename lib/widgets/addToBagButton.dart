// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tej_mart/constants/colors.dart';
import 'package:tej_mart/constants/sizes.dart';
import 'package:tej_mart/services/favouritescreen.dart';

import '../services/cart_service.dart';

class MyAddToBagButton extends StatefulWidget {
  final String user_id;
  final String product_id;
  final int quantity_product;
  const MyAddToBagButton({
    Key? key,
    required this.user_id,
    required this.product_id,
    required this.quantity_product,
  }) : super(key: key);

  @override
  State<MyAddToBagButton> createState() => _MyAddToBagButtonState();
}

class _MyAddToBagButtonState extends State<MyAddToBagButton> {
  bool isWishlisted = false;
  String? data;
  addToWishlist(String user_id, String product_id) async {
    await FavouriteService().addToWishlist(
        context: context, product_id: product_id, user_id: user_id);
  }

  addToCart(String user_id, String product_id, int quantity_product) async {
    await CartService().addToCart(
        user_id: user_id,
        product_id: product_id,
        quantity_product: quantity_product,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.quantity_product);
    return Container(
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: indigo,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: GestureDetector(
              onTap: () {
                if (!isWishlisted) {
                  addToWishlist(widget.user_id, widget.product_id);
                  setState(() {
                    isWishlisted = true;
                  });
                } else {
                  setState(() {
                    isWishlisted = false;
                  });
                }
              },
              child: Row(
                children: [
                  isWishlisted
                      ? Icon(
                          FluentSystemIcons.ic_fluent_heart_filled,
                          color: white,
                        )
                      : Icon(
                          Icons.favorite_outline,
                          color: white,
                        ),
                  Text(
                    "  WISHLIST",
                    style: GoogleFonts.montserrat()
                        .copyWith(color: white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          Gap(10),
          GestureDetector(
            onTap: () {
              addToCart(
                  widget.user_id, widget.product_id, widget.quantity_product);
            },
            child: Container(
              height: 40,
              width: getWidth(0.4, context),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: indigo,
                  ),
                  Text(
                    "  ADD TO BAG",
                    style: GoogleFonts.montserrat().copyWith(
                        color: indigo,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
