// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:tej_mart/SalesExecutives/models/sales_addProduct.dart';
import 'package:tej_mart/controller/user_controller.dart';
import 'package:tej_mart/providers/customer_provider.dart';
import 'package:tej_mart/services/favouritescreen.dart';

import '../constants/colors.dart';

class MyOneSearch extends StatefulWidget {
  final SalesAddProductModel product;
  const MyOneSearch({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<MyOneSearch> createState() => _MyOneFavouriteState();
}

class _MyOneFavouriteState extends State<MyOneSearch> {
  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    final user = Provider.of<CustomerProvider>(context, listen: false).user;
    double discountedPrice =
        widget.product.price * (1 - (widget.product.discount / 100.00));
    return Container(
      height: 130,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
      decoration: BoxDecoration(
        color: lightGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            height: 110,
            width: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              //image
              image: DecorationImage(
                  image: CachedNetworkImageProvider(widget.product.images[0]),
                  fit: BoxFit.cover),
            ),
          ),
          Gap(15),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    maxLines: 2,
                    style: GoogleFonts.montserrat().copyWith(
                        color: black,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis),
                  ),
                  Gap(5),
                  Row(
                    children: [
                      Text(
                        "\$${discountedPrice}  ",
                        style: GoogleFonts.montserrat().copyWith(
                            color: black,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 15),
                      ),
                      Text(
                        "\$${widget.product.price}",
                        style: GoogleFonts.montserrat().copyWith(
                            color: grey,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: grey,
                            fontSize: 15),
                      ),
                      Text(
                        " ${widget.product.discount}%",
                        style: GoogleFonts.montserrat().copyWith(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 15),
                      ),
                    ],
                  ),
                  Text(
                    "In Stock",
                    style: GoogleFonts.montserrat().copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 11),
                  ),
                  Row(
                    children: [
                      Text(
                        "Sold by ",
                        maxLines: 1,
                        style: GoogleFonts.montserrat().copyWith(
                          color: grey,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        "${widget.product.shop_name}",
                        maxLines: 1,
                        style: GoogleFonts.montserrat().copyWith(
                          color: Colors.cyan,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Gap(5),
          // GestureDetector(
          //   onTap: () async {
          //     userController.removeWishListItem(
          //         context: context,
          //         productId: widget.product.id,
          //         userId: user.id);
          //   },
          //   child: Container(
          //     height: 40,
          //     width: 40,
          //     decoration: BoxDecoration(
          //         color: Color.fromARGB(53, 242, 15, 38),
          //         borderRadius: BorderRadius.circular(
          //           10,
          //         )),
          //     child: Icon(
          //       Icons.delete,
          //       color: red,
          //       size: 28,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
