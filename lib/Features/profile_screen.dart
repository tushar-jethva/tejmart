import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:tej_mart/Features/init_screen.dart';
import 'package:tej_mart/Features/order_details.dart';
import 'package:tej_mart/SalesExecutives/models/sales_addProduct.dart';
import 'package:tej_mart/constants/colors.dart';
import 'package:tej_mart/constants/images_link.dart';
import 'package:tej_mart/constants/style.dart';
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
        title: Text(
          "Welcome ${user.name}",
          style: textStyle().copyWith(color: black),
        ),
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, MyInitScreen.routeName, (route) => false);
              },
              child: const Icon(Icons.logout))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(40),
          Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: lightGrey,
                  backgroundImage: CachedNetworkImageProvider(
                    userimage,
                  ),
                ),
              ),
              Text(
                user.name,
                style: textStyle().copyWith(color: black),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 30,
              left: 15,
              right: 15,
            ),
            child: Text(
              "My Orders",
              style: textStyle().copyWith(
                  color: black, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          list != null
              ? list!.isNotEmpty
                  ? SizedBox(
                      height: 200,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: list!.length,
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
