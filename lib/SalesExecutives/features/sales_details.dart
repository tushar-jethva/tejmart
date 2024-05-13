// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tej_mart/SalesExecutives/services/sales_prooduct_service.dart';
import 'package:tej_mart/SalesExecutives/widgets/sales_order_detail_bottom.dart';
import 'package:tej_mart/constants/style.dart';
import 'package:tej_mart/widgets/custom_button.dart';

import '../../constants/colors.dart';
import '../models/sales_addProduct.dart';

class MySalesDetailssScreen extends StatefulWidget {
  SalesAddProductModel produt;
  Map<String, dynamic> map;
  bool isCompleted;
  MySalesDetailssScreen({
    Key? key,
    required this.produt,
    required this.map,
    this.isCompleted = false,
  }) : super(key: key);

  @override
  State<MySalesDetailssScreen> createState() => _MySalesDetailsScreenState();
}

class _MySalesDetailsScreenState extends State<MySalesDetailssScreen> {
  late final PageController pageController;
  late Timer timer;
  int currIndex = 0;
  int number = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SalesAddProductModel salesAddProductModel = widget.produt;
    pageController = PageController(initialPage: 0);
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      pageController.animateToPage(
          currIndex % salesAddProductModel.images.length,
          duration: Duration(seconds: 3),
          curve: Curves.fastOutSlowIn);
      currIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    SalesAddProductModel object = widget.produt;
    double discountedPrice = object.price * (1 - (object.discount / 100.00));
    return Scaffold(
        appBar: AppBar(
            leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios_new)),
            title: Text(
              object.name,
              style: textStyle(),
            )),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 270,
                    child: PageView(
                      controller: pageController,
                      // ignore: sort_child_properties_last
                      children: object.images
                          .map(
                            (e) => Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(e),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          )
                          .toList(),
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (value) {
                        setState(() {
                          currIndex = value;
                        });
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 175,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          object.images.length,
                          (index) => Container(
                                padding: const EdgeInsets.all(3),
                                child: currIndex % object.images.length == index
                                    ? Container(
                                        width: 22,
                                        height: 8,
                                        decoration: BoxDecoration(
                                            color: orange,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      )
                                    : Container(
                                        width: 5,
                                        height: 10,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey),
                                      ),
                              )),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(10),
                    Text(
                      object.name,
                      style: GoogleFonts.montserrat().copyWith(
                          color: black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Gap(3),
                    Text(
                      object.description,
                      style: GoogleFonts.montserrat()
                          .copyWith(color: Colors.black54, fontSize: 11),
                    ),
                    Gap(12),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: "\$${discountedPrice}  ",
                        style: GoogleFonts.montserrat().copyWith(
                            color: black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      TextSpan(
                        text: "\$${object.price}",
                        style: GoogleFonts.montserrat().copyWith(
                            color: grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            decoration: TextDecoration.lineThrough,
                            textBaseline: TextBaseline.alphabetic),
                      ),
                      TextSpan(
                        text: "  (${object.discount}% off)",
                        style: GoogleFonts.montserrat().copyWith(
                            color: green,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )
                    ])),
                    Text(
                      "inclusive of all taxes",
                      style: GoogleFonts.montserrat().copyWith(
                          color: indigo,
                          fontWeight: FontWeight.bold,
                          fontSize: 11),
                    ),
                    Gap(10),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: !widget.isCompleted
            ? MyOrderBottom(
              sales_id: object.sales_id,
                order_id: widget.map['order_id'],
                product_id: object.id,
              )
            : SizedBox.shrink());
  }
}
