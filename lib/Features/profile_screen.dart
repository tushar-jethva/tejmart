import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tej_mart/Features/all_orders_screen.dart';
import 'package:tej_mart/Features/homescreen.dart';
import 'package:tej_mart/Features/init_screen.dart';
import 'package:tej_mart/Features/order_details.dart';
import 'package:tej_mart/constants/colors.dart';
import 'package:tej_mart/constants/constants.dart';
import 'package:tej_mart/constants/images_link.dart';
import 'package:tej_mart/constants/sizes.dart';
import 'package:tej_mart/constants/style.dart';
import 'package:tej_mart/controller/user_controller.dart';
import 'package:tej_mart/services/auth_service.dart';
import 'package:tej_mart/services/order_service.dart';
import 'package:tej_mart/widgets/order_container.dart';

import '../models/address_and_amount.dart';
import '../providers/customer_provider.dart';

class MyProfileScreen extends StatefulWidget {
  static const routeName = "/profile";
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final userController = Get.put(UserController());
  AddressAndAmountModel? details;
  List<Map<String, dynamic>>? list;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var user = Provider.of<CustomerProvider>(context, listen: false).user;
      getAddressAndAmount(user.id);
      getAllUserOrders(user.id);
    });
    userController.getImage();
  }

  getAddressAndAmount(String user_id) async {
    details =
        await UserAuthService().getUser(context: context, user_id: user_id);
    setState(() {});
  }

  getAllUserOrders(String user_id) async {
    list = await OrderServices()
        .getAllUserOrders(context: context, user_id: user_id);
    setState(() {});
    // print(list);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomerProvider>(context, listen: false).user;
    print("User ${user.name}");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Welcome ${user.name}",
          style: textStyle().copyWith(color: black),
        ),
        actions: [
          GestureDetector(
              onTap: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.setString('x-auth-token', "");
                pref.setString("path", "");
                Navigator.pushNamedAndRemoveUntil(
                    context, MyInitScreen.routeName, (route) => false);
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Icon(Icons.logout),
              ))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(40),
          Column(
            children: [
              Center(
                child: Stack(children: [
                  Obx(
                    () => CircleAvatar(
                        radius: 50,
                        backgroundColor: lightGrey,
                        backgroundImage: userController.path.isNotEmpty
                            ? FileImage(File(userController.path.value))
                            : const AssetImage("assets/logotej.png")
                                as ImageProvider),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 5,
                      child: GestureDetector(
                        onTap: () async {
                          XFile? image =
                              await pickOneImage(source: ImageSource.gallery);
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString("path", image!.path);
                          userController.getImage();
                        },
                        child: Icon(
                          Icons.add,
                          color: Colors.indigo,
                        ),
                      )),
                ]),
              ),
              const Gap(10),
              Text(
                user.name,
                style: textStyle().copyWith(color: black),
              )
            ],
          ),
          Gap(getHeight(0.05, context)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(0.03, context)),
            child: MyHeaderText(
              leftText: "My Orders",
              rightText: "See all",
              fontSize: 20,
              onRightTap: () {
                Navigator.pushNamed(context, MyAllOrdersScreen.routeName,
                    arguments: list);
              },
            ),
          ),
          Gap(getHeight(0.01, context)),
          list != null
              ? list!.isNotEmpty
                  ? SizedBox(
                      height: 200,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: list!.length > 3 ? 3 : list!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, MyOrderDetails.routeName,
                                    arguments: {"products": list![index]});
                              },
                              child: MyOrderContainer(
                                product: list![index],
                              ),
                            );
                          }),
                    )
                  : const Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Center(child: Text("No Orders found!")),
                    )
              : const Center(
                  child: CircularProgressIndicator(),
                )
        ],
      ),
    );
  }
}
