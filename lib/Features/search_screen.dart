import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tej_mart/Features/details_screen.dart';
import 'package:tej_mart/constants/sizes.dart';
import 'package:tej_mart/controller/user_controller.dart';
import 'package:tej_mart/widgets/cutsom_textfield.dart';
import 'package:tej_mart/widgets/search_widget.dart';

import '../constants/colors.dart';

class MySearchScreen extends StatefulWidget {
  static const routeName = "/searchScreen";
  const MySearchScreen({super.key});

  @override
  State<MySearchScreen> createState() => _MySearchScreenState();
}

class _MySearchScreenState extends State<MySearchScreen> {
  final userController = Get.put(UserController());
  final FocusNode searchFocus = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userController.searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, getHeight(0.11, context)),
          child: Padding(
            padding: EdgeInsets.only(
                top: getHeight(0.05, context),
                left: getWidth(0.03, context),
                right: getWidth(0.04, context),
                bottom: getHeight(0.03, context)),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios_new),
                ),
                Gap(getWidth(0.05, context)),
                Expanded(
                    child: TextField(
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  focusNode: searchFocus,
                  controller: userController.searchController,
                  keyboardType: TextInputType.text,
                  style: GoogleFonts.montserrat(),
                  decoration: InputDecoration(
                    hintText: "Search products...",
                    hintStyle: GoogleFonts.montserrat().copyWith(color: grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: grey, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: blue, width: 1),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ),
        body: Obx(
          () => userController.searchProductsList.isEmpty
              ? Center(
                  child: Text(
                    "No data found!",
                    style: GoogleFonts.montserrat(),
                  ),
                )
              : ListView.builder(
                  itemCount: userController.searchProductsList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, MyDetailsScreen.routeName,
                            arguments: {
                              'product':
                                  userController.searchProductsList[index],
                              'name': userController
                                  .searchProductsList[index].category
                            });
                      },
                      child: MyOneSearch(
                          product: userController.searchProductsList[index]),
                    );
                  }),
        ));
  }
}
