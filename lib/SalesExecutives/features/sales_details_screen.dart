// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tej_mart/SalesExecutives/controllers/sales_home_controller.dart';
import 'package:tej_mart/SalesExecutives/models/sales_addProduct.dart';
import 'package:tej_mart/SalesExecutives/services/sales_prooduct_service.dart';
import 'package:tej_mart/SalesExecutives/widgets/delete_button.dart';
import 'package:tej_mart/constants/constants.dart';
import 'package:tej_mart/constants/style.dart';
import 'package:tej_mart/widgets/addToBagButton.dart';
import 'package:tej_mart/widgets/auth_custom_button.dart';
import 'package:tej_mart/widgets/custom_button.dart';
import 'package:tej_mart/widgets/loader.dart';
import 'package:tej_mart/widgets/quantity.dart';
import 'package:tej_mart/widgets/search_bar.dart';
import '../../constants/colors.dart';

class MySalesDetailsScreen extends StatefulWidget {
  static const routeName = "/salesDetailScreen";
  Map<String, dynamic> map;
  MySalesDetailsScreen({
    Key? key,
    required this.map,
  }) : super(key: key);

  @override
  State<MySalesDetailsScreen> createState() => _MySalesDetailsScreen();
}

class _MySalesDetailsScreen extends State<MySalesDetailsScreen> {
  late final PageController pageController;
  final salesHomeController = Get.put(MySalesController());

  late Timer timer;
  int currIndex = 0;
  int number = 0;
  List<Widget> list = [
    Image.asset('assets/pic6.jpg'),
    Image.asset('assets/pic7.jpg'),
    Image.asset('assets/pic8.jpg'),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SalesAddProductModel salesAddProductModel = widget.map['product'];
    pageController = PageController(initialPage: 0);
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      pageController.animateToPage(
          currIndex % salesAddProductModel.images.length,
          duration: const Duration(seconds: 3),
          curve: Curves.fastOutSlowIn);
      currIndex++;
    });
  }

  bool isDelete = false;

  deleteProduct(String id) async {
    setState(() {
      isDelete = true;
    });
    await SalesProductService().deleleProduct(
      context: context,
      product_id: id,
    );

    salesHomeController.getAllProducts(
        context: context, sales_id: widget.map['product'].sales_id);
    setState(() {
      isDelete = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    SalesAddProductModel object = widget.map['product'];
    double discountedPrice = object.price * (1 - (object.discount / 100.00));
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new)),
        title: Text(object.name),

        // flexibleSpace: MySearchBar(name: widget.map['name']!),
      ),
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
                    children: object.images
                        .map(
                          (e) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
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
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              )
                            : Container(
                                width: 5,
                                height: 10,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromARGB(255, 108, 107, 107)),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  Row(
                    children: [
                      Text(
                        "Quantity: ",
                        style: GoogleFonts.montserrat().copyWith(
                            color: black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      Text(
                        "${object.quantity.toString()}",
                        style: textStyle().copyWith(fontSize: 17),
                      )
                    ],
                  ),
                  Gap(10),
                  Gap(220),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            deleteProduct(object.id);
          },
          child: MyAuthCustomButton(
            borderColor: red,
            widget: isDelete
                ? MyLoader(color: white)
                : Text(
                    "Delete",
                    style: textStyle().copyWith(fontSize: 15, color: white),
                  ),
            color: red,
            textColor: white,
          ),
        ),
      ),
    );
  }
}
