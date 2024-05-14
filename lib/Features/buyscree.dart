// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:tej_mart/constants/colors.dart';
import 'package:tej_mart/constants/constants.dart';
import 'package:tej_mart/constants/style.dart';
import 'package:tej_mart/controller/user_controller.dart';
import 'package:tej_mart/models/address_and_amount.dart';
import 'package:tej_mart/providers/customer_provider.dart';
import 'package:tej_mart/services/auth_service.dart';
import 'package:tej_mart/services/order_service.dart';
import 'package:tej_mart/widgets/auth_custom_button.dart';
import 'package:tej_mart/widgets/custom_button.dart';
import 'package:tej_mart/widgets/loader.dart';

class MyBuyScreen extends StatefulWidget {
  static const routeName = '/buyScreen';
  final Map<String, dynamic> map;
  const MyBuyScreen({
    Key? key,
    required this.map,
  }) : super(key: key);

  @override
  State<MyBuyScreen> createState() => _MyBuyScreenState();
}

class _MyBuyScreenState extends State<MyBuyScreen> {
  final TextEditingController _addressControlle = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();
  final userController = Get.put(UserController());
  bool isPlaced = false;

  AddressAndAmountModel? details;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _addressControlle.dispose();
    _mobileNoController.dispose();
    _balanceController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var user = Provider.of<CustomerProvider>(context, listen: false).user;
      getAddressAndAmount(user.id);
    });
  }

  getAddressAndAmount(String user_id) async {
    details =
        await UserAuthService().getUser(context: context, user_id: user_id);
    setState(() {});
    print(details);
  }

  final OrderServices orderServices = OrderServices();
  void addAddressAndMobile(String user_id) async {
    await orderServices.addAddressAndMobileNo(
        address: _addressControlle.text,
        mobile_no: _mobileNoController.text,
        user_id: user_id,
        context: context);
    getAddressAndAmount(user_id);
    setState(() {});
  }

  void addAmount(String user_id) async {
    await orderServices.addAmount(
        amount: int.parse(_balanceController.text),
        user_id: user_id,
        context: context);
    getAddressAndAmount(user_id);
    setState(() {});
  }

  void placeOrder(
      String user_id, List<String> products, double total_amount) async {
    setState(() {
      isPlaced = true;
    });
    await orderServices.placeOrder(
        context: context,
        products: products,
        user_id: user_id,
        total_amount: total_amount);
    setState(() {
      isPlaced = false;
    });
  }

  openDialog(String user_id) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Amount",
              style: textStyle().copyWith(color: indigo, fontSize: 23),
            ),
            backgroundColor: white,
            content: Container(
              height: 180,
              child: Column(
                children: [
                  Gap(30),
                  TextField(
                    controller: _balanceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Enter Amount",
                        hintStyle: textStyle().copyWith(color: indigo),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: indigo),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: indigo),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: indigo),
                        )),
                  ),
                  Gap(20),
                  GestureDetector(
                    onTap: () {
                      if (double.parse(_balanceController.text) > 0) {
                        addAmount(user_id);
                        Navigator.pop(context);
                        _balanceController.text = "0";
                      } else {
                        showSnackBar(context, "Amount must be greater than 0");
                      }
                    },
                    child: MyCustomButton(
                        color: indigo,
                        name: "Add Amount",
                        textColor: white,
                        borderColor: black),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomerProvider>(context, listen: false).user;
    print(widget.map);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          "Checkout",
          style: GoogleFonts.montserrat().copyWith(color: black, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: details != null
                  ? details!.address.isEmpty
                      ? details!.mobile_no.isEmpty
                          ? 310
                          : details!.address.isEmpty
                              ? 200
                              : 220
                      : 200
                  : 220,
              margin: const EdgeInsets.only(top: 60, right: 10, left: 10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: indigo,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  details != null
                      ? details!.address.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  details != null ? details!.address : "",
                                  style: textStyle()
                                      .copyWith(color: white, fontSize: 15),
                                ),
                                Gap(5),
                                Text(
                                  details != null
                                      ? "PhoneNo:  ${details!.mobile_no}"
                                      : "",
                                  style: textStyle()
                                      .copyWith(color: white, fontSize: 15),
                                )
                              ],
                            )
                          : TextField(
                              controller: _addressControlle,
                              style: textStyle().copyWith(color: white),
                              maxLines: 3,
                              cursorColor: white,
                              decoration: InputDecoration(
                                  hintText: user.address.isEmpty
                                      ? "Enter your Address"
                                      : "Enter new Address",
                                  hintStyle: textStyle().copyWith(color: white),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: white),
                                  )),
                            )
                      : SizedBox.shrink(),
                  Gap(20),
                  details != null
                      ? details!.mobile_no.isEmpty
                          ? TextField(
                              controller: _mobileNoController,
                              style: textStyle().copyWith(color: white),
                              maxLines: 1,
                              cursorColor: white,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  hintText: "Enter MobileNo.",
                                  hintStyle: textStyle().copyWith(color: white),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: white),
                                  )),
                            )
                          : SizedBox.shrink()
                      : SizedBox.shrink(),
                  Gap(20),
                  details != null
                      ? details!.address.isEmpty
                          ? GestureDetector(
                              onTap: () {
                                if (details!.address.isEmpty &&
                                    details!.mobile_no.isEmpty) {
                                  if (_addressControlle.text.isNotEmpty &&
                                      _mobileNoController.text.length == 10) {
                                    addAddressAndMobile(user.id);
                                  } else {
                                    if (_addressControlle.text.isEmpty) {
                                      showSnackBar(
                                          context, "Please enter address");
                                    } else if (_mobileNoController
                                        .text.isEmpty) {
                                      showSnackBar(
                                          context, "Please enter mobileNo.");
                                    } else {
                                      showSnackBar(context,
                                          "Please enter valid mobileNo.");
                                    }
                                  }
                                }
                              },
                              child: MyCustomButton(
                                borderColor: white,
                                color: white,
                                textColor: black,
                                name: "Deliver to this address",
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                showSnackBar(
                                    context, "Functionality coming soon!");
                              },
                              child: MyCustomButton(
                                borderColor: white,
                                color: white,
                                textColor: black,
                                name: "Add new Address!",
                              ),
                            )
                      : SizedBox.shrink(),
                ],
              ),
            ),
            Container(
              height: 90,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 17, right: 10, left: 10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: indigo,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your balance",
                        style: textStyle().copyWith(
                            color: white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        details != null
                            ? "\$${details!.a_balance.toStringAsFixed(2)}"
                            : "0.0",
                        style: textStyle().copyWith(color: white, fontSize: 20),
                      )
                    ],
                  ),
                  Gap(90),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        openDialog(user.id);
                      },
                      child: MyCustomButton(
                          color: white,
                          name: "Add Amount",
                          textColor: black,
                          borderColor: white),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 17, right: 10, left: 10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: indigo,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Orders",
                    style: textStyle().copyWith(color: white, fontSize: 22),
                  ),
                  Gap(20),
                  Text(
                    "Total items:  ${widget.map['total_items']}",
                    style: textStyle()
                        .copyWith(color: white)
                        .copyWith(fontSize: 16),
                  ),
                  Text(
                    "Grand Total:  \$${(widget.map['total'] as double).toStringAsFixed(2)}",
                    style: textStyle().copyWith(color: white, fontSize: 16),
                  ),
                  const Gap(10),
                  GestureDetector(
                    onTap: () {
                      double balance = double.parse(widget.map['total']!);
                      if (details != null) {
                        if (details!.a_balance >= balance &&
                            details!.address.isNotEmpty &&
                            details!.mobile_no.isNotEmpty) {
                          placeOrder(user.id, widget.map['products'], balance);
                          userController.list.clear();
                        } else {
                          String data = "";
                          if (details!.address.isEmpty) {
                            data = "Please enter address";
                            showSnackBar(context, data);
                          } else if (details!.mobile_no.isEmpty) {
                            data = "Please enter mobileNo";
                            showSnackBar(context, data);
                          } else {
                            data = "Insufficient balance";
                            showSnackBar(context, data);
                          }
                        }
                      }
                    },
                    child: MyAuthCustomButton(
                      color: white,
                      textColor: black,
                      borderColor: white,
                      widget: isPlaced
                          ? MyLoader(color: indigo)
                          : Text(
                              "Pay",
                              style: textStyle()
                                  .copyWith(color: black, fontSize: 15),
                            ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
