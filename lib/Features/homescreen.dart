import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tej_mart/Features/cartscreen.dart';
import 'package:tej_mart/Features/category_items.dart';
import 'package:tej_mart/Features/search_screen.dart';
import 'package:tej_mart/SalesExecutives/models/sales_addProduct.dart';
import 'package:tej_mart/constants/colors.dart';
import 'package:tej_mart/constants/images_link.dart';
import 'package:tej_mart/constants/sizes.dart';
import 'package:tej_mart/controller/user_controller.dart';
import 'package:tej_mart/providers/customer_provider.dart';
import 'package:tej_mart/services/product_service.dart';
import 'package:tej_mart/widgets/circle_avatar.dart';
import 'package:tej_mart/widgets/cutsom_textfield.dart';
import 'package:tej_mart/widgets/one_carousel.dart';
import 'package:tej_mart/widgets/trending_container.dart';

class MyHomeScreen extends StatefulWidget {
  static const routeName = '/homescreen';
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  List<Widget> photos = [
    MyOneCarousel(image: cs1),
    MyOneCarousel(image: cs2),
    MyOneCarousel(image: cs3),
    MyOneCarousel(image: cs4),
  ];
  late final PageController pageController;
  late Timer timer;
  int currIndex = 0;
  List<SalesAddProductModel>? list;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(initialPage: 0);
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      pageController.animateToPage(currIndex % photos.length,
          duration: const Duration(seconds: 2), curve: Curves.fastOutSlowIn);
      currIndex++;
    });
  }

  getAllSystemProducts() async {
    list =
        await CustomerProductService().getAllSystemProducts(context: context);
    setState(() {});
  }

  List<Map<String, String>> categories = [
    {
      "title": "Men",
      "url": men,
    },
    {
      "title": "Women",
      "url": women,
    },
    {
      "title": "Kids",
      "url": kid,
    },
    {
      "title": "Footwear",
      "url": footwear,
    },
    {
      "title": "Beauty",
      "url": beauty,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final cust = Provider.of<CustomerProvider>(context, listen: false).user;
    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap(40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, MySearchScreen.routeName);
                    },
                    child: Icon(
                      Icons.search,
                      size: 25,
                    ),
                  ),
                  Text(
                    'TezzFashion',
                    style: GoogleFonts.montserrat().copyWith(
                        color: indigo,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, MyCartScreen.routeName,
                          arguments: {'user_id': cust.id});
                    },
                    child: const Icon(
                      Icons.shopping_bag_rounded,
                      size: 27,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                "Discover & find cool product fit your style",
                style: GoogleFonts.montserrat().copyWith(
                    color: black, fontWeight: FontWeight.w900, fontSize: 22),
              ),
            ),
            const Gap(20),
            SizedBox(
              height: getHeight(0.12, context),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: ((context, index) {
                    return SizedBox(
                      width: getWidth(0.22, context),
                      child: MyCircleAvatar(
                        url: categories[index]['url']!,
                        name: categories[index]['title']!,
                        fun: () {
                          print("cat ${categories[index]['title']}");
                          Navigator.pushNamed(context, MyCategoryList.routeName,
                              arguments: {
                                "name": categories[index]['title'].toString()
                              });
                        },
                      ),
                    );
                  })),
            ),
            const Gap(10),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: PageView(
                controller: pageController,
                children: photos,
                onPageChanged: (value) {
                  currIndex = value;
                  setState(() {});
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                photos.length,
                (index) => Container(
                  padding: const EdgeInsets.all(3),
                  child: currIndex % photos.length == index
                      ? Container(
                          width: 22,
                          height: 8,
                          decoration: BoxDecoration(
                              color: orange,
                              borderRadius: BorderRadius.circular(10)),
                        )
                      : Container(
                          width: 5,
                          height: 10,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey),
                        ),
                ),
              ),
            ),
            Gap(20),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: getWidth(0.05, context)),
              child: MyHeaderText(
                leftText: "Trending this week",
                rightText: "See all",
                fontSize: 15,
                onRightTap: () {},
              ),
            ),
            const Gap(20),

            // const Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     MyTrendingContainer(
            //       itemName: "Suit",
            //       price: 100,
            //       forName: "Men",
            //       url:
            //           "https://img.freepik.com/free-vector/flat-spring-social-media-post-template_23-2149291888.jpg?w=900&t=st=1702316337~exp=1702316937~hmac=9816a124f21c48f10ba02e7a1d2b3ba77481a2ff47c5ac1293f17881fa4249c7",
            //     ),
            //     MyTrendingContainer(
            //       itemName: "Suit",
            //       forName: "Man",
            //       price: 50,
            //       url:
            //           "https://img.freepik.com/free-vector/flat-spring-social-media-post-template_23-2149291888.jpg?w=900&t=st=1702316337~exp=1702316937~hmac=9816a124f21c48f10ba02e7a1d2b3ba77481a2ff47c5ac1293f17881fa4249c7",
            //     ),
            //   ],
            // ),
            // const Gap(20),
            // const Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     MyTrendingContainer(
            //       itemName: "Suit",
            //       forName: "Man",
            //       price: 50,
            //       url:
            //           "https://img.freepik.com/free-vector/flat-spring-social-media-post-template_23-2149291888.jpg?w=900&t=st=1702316337~exp=1702316937~hmac=9816a124f21c48f10ba02e7a1d2b3ba77481a2ff47c5ac1293f17881fa4249c7",
            //     ),
            //     MyTrendingContainer(
            //       itemName: "Suit",
            //       forName: "Man",
            //       price: 50,
            //       url:
            //           "https://img.freepik.com/free-vector/flat-spring-social-media-post-template_23-2149291888.jpg?w=900&t=st=1702316337~exp=1702316937~hmac=9816a124f21c48f10ba02e7a1d2b3ba77481a2ff47c5ac1293f17881fa4249c7",
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

class MyHeaderText extends StatelessWidget {
  final String leftText;
  final String rightText;
  final double fontSize;
  final VoidCallback onRightTap;
  const MyHeaderText(
      {super.key,
      required this.leftText,
      required this.rightText,
      required this.fontSize,
      required this.onRightTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leftText,
          style: GoogleFonts.montserrat().copyWith(
              color: black, fontWeight: FontWeight.bold, fontSize: fontSize),
        ),
        GestureDetector(
          onTap: onRightTap,
          child: Text(
            rightText,
            style: GoogleFonts.montserrat().copyWith(
                color: indigo, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        )
      ],
    );
  }
}
