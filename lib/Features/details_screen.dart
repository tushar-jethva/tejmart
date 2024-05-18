import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tej_mart/SalesExecutives/models/sales_addProduct.dart';
import 'package:tej_mart/constants/style.dart';
import 'package:tej_mart/providers/customer_provider.dart';
import 'package:tej_mart/widgets/addToBagButton.dart';
import 'package:tej_mart/widgets/search_bar.dart';
import '../constants/colors.dart';

// ignore: must_be_immutable
class MyDetailsScreen extends StatefulWidget {
  static const routeName = "/detailScreen";
  Map<String, dynamic> map;
  MyDetailsScreen({
    Key? key,
    required this.map,
  }) : super(key: key);

  @override
  State<MyDetailsScreen> createState() => _MyDetailsScreenState();
}

class _MyDetailsScreenState extends State<MyDetailsScreen> {
  late final PageController pageController;
  late Timer timer;
  int currIndex = 0;
  int number = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SalesAddProductModel salesAddProductModel = widget.map['product'];
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
    final user = Provider.of<CustomerProvider>(context, listen: false).user;
    SalesAddProductModel object = widget.map['product'];
    double discountedPrice = object.price * (1 - (object.discount / 100.00));
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios_new)),
        title: Text(
          object.name,
          style: GoogleFonts.montserrat(),
        ),

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
                    // ignore: sort_child_properties_last
                    children: object.images
                        .map(
                          (e) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
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
                      text: "\$${discountedPrice.toStringAsFixed(2)}  ",
                      style: GoogleFonts.montserrat().copyWith(
                          color: black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    TextSpan(
                      text: "\$${object.price.toStringAsFixed(2)}",
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
                  Text(
                    "Quantity:",
                    style: GoogleFonts.montserrat().copyWith(
                        color: black,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                  Gap(10),
                  Container(
                    width: 170,
                    height: 50,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 240, 240, 240),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                            onTap: () {
                              if (number > 1) {
                                number--;
                                setState(() {});
                                // CartService().decrementQuantity(
                                //     context: context, product_id: object.id);
                              }
                            },
                            child: const Icon(
                              FluentSystemIcons.ic_fluent_remove_regular,
                              size: 20,
                            )),
                        Text(
                          number.toString(),
                          style: textStyle().copyWith(fontSize: 18),
                        ),
                        GestureDetector(
                            onTap: () {
                              if (number < 6) number++;
                              setState(() {});
                            },
                            child: const Icon(
                              FluentSystemIcons.ic_fluent_add_regular,
                              size: 20,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: MyAddToBagButton(
            product_id: object.id, user_id: user.id, quantity_product: number),
      ),
    );
  }
}
