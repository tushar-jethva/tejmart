// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tej_mart/constants/colors.dart';
import 'package:tej_mart/constants/constants.dart';
import 'package:tej_mart/controller/user_controller.dart';
import 'package:tej_mart/providers/cart_provider.dart';
import 'package:tej_mart/services/cart_service.dart';
import '../constants/style.dart';

class MyOneCartItem extends StatefulWidget {
  final String user_id;
  final String id;
  final String itemName;
  final String shopName;
  final double disPrice;
  final int oriPrice;
  final int discount;
  final String image;
  final int quantity;
  final Color color;
  final bool isQuantityRequired;
  const MyOneCartItem(
      {Key? key,
      required this.user_id,
      required this.itemName,
      required this.shopName,
      required this.disPrice,
      required this.oriPrice,
      required this.discount,
      required this.image,
      required this.color,
      required this.id,
      required this.quantity,
      this.isQuantityRequired = true})
      : super(key: key);

  @override
  State<MyOneCartItem> createState() => _MyOneCartItemState();
}

class _MyOneCartItemState extends State<MyOneCartItem> {
  final userController = Get.put(UserController());

  bool itemDelete = false;
  deleteItem() async {
    await CartService().deleteFromCart(
      context: context,
      product_id: widget.id,
      onSuccess: () {
        print("Delete");
        userController.getAllCustomerCartProducts(
            user_id: widget.user_id, context: context);
        showSnackBar(context, "Deleted");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int number = widget.quantity;
    return Container(
      height: 130,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
      decoration: BoxDecoration(
        color: widget.color,
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
                  image: CachedNetworkImageProvider(widget.image),
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
                    widget.itemName,
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
                        "\$${widget.disPrice}  ",
                        style: GoogleFonts.montserrat().copyWith(
                            color: black,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 15),
                      ),
                      Text(
                        "\$${widget.oriPrice}",
                        style: GoogleFonts.montserrat().copyWith(
                            color: grey,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: grey,
                            fontSize: 15),
                      ),
                      Text(
                        " ${widget.discount}%",
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
                        "${widget.shopName}",
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
                  widget.isQuantityRequired
                      ? Text("x${widget.quantity}")
                      : SizedBox.shrink()
                ],
              ),
            ),
          ),
          Gap(5),
          GestureDetector(
            onTap: () {
              deleteItem();
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Color.fromARGB(53, 242, 15, 38),
                  borderRadius: BorderRadius.circular(
                    10,
                  )),
              child: Icon(
                Icons.delete,
                color: red,
                size: 28,
              ),
            ),
          )
        ],
      ),
    );
  }
}
