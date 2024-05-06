import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tej_mart/Features/signin.dart';
import 'package:tej_mart/SalesExecutives/features/sales_sign_in.dart';
import 'package:tej_mart/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tej_mart/widgets/custom_button.dart';

class MyInitScreen extends StatefulWidget {
  static const routeName = '/initscreen';
  const MyInitScreen({super.key});

  @override
  State<MyInitScreen> createState() => _MyInitScreenState();
}

class _MyInitScreenState extends State<MyInitScreen> {
  late final PageController pageController;
  late Timer timer;
  int currIndex = 0;
  List<Widget> list = [
    Image.asset('assets/pic6.jpg'),
    Image.asset('assets/pic7.jpg'),
    Image.asset('assets/pic8.jpg'),
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      pageController.animateToPage(currIndex % list.length,
          duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      currIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 490,
                child: PageView(
                  controller: pageController,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (value) {
                    setState(() {
                      currIndex = value;
                    });
                  },
                  children: list,
                ),
              ),
              Positioned(
                bottom: 30,
                right: 175,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      list.length,
                      (index) => Container(
                            padding: const EdgeInsets.all(3),
                            child: currIndex % list.length == index
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
          Text(
            'Welcome to TEJMart!',
            style: GoogleFonts.montserrat().copyWith(
                color: blue, fontSize: 20, fontWeight: FontWeight.w700),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Center(
              child: Text(
                'Now to get ready to embark on a seamless and delightful to bring you the best of shopping experience at your fingertips!',
                style: GoogleFonts.montserrat().copyWith(
                    color: blue, fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          const Gap(80),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, MySignInScreen.routeName);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyCustomButton(
                color: blue,
                name: "LogIn as Customer",
                textColor: white,
                borderColor: black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, MySalesSignIn.routeName, (route) => false);
              },
              child: MyCustomButton(
                color: white,
                name: "LogIn as Salesman",
                textColor: black,
                borderColor: blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
