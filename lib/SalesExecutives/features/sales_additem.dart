import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:tej_mart/SalesExecutives/controllers/sales_home_controller.dart';
import 'package:tej_mart/SalesExecutives/services/sales_prooduct_service.dart';
import 'package:tej_mart/constants/colors.dart';
import 'package:tej_mart/constants/constants.dart';
import 'package:tej_mart/constants/style.dart';
import 'package:tej_mart/providers/salse_user_provider.dart';
import 'package:tej_mart/widgets/auth_custom_button.dart';
import 'package:tej_mart/widgets/cutsom_textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:tej_mart/widgets/loader.dart';

class MySalesAddProductScreen extends StatefulWidget {
  static const routeName = "/addProduct";
  const MySalesAddProductScreen({super.key});

  @override
  State<MySalesAddProductScreen> createState() =>
      _MySalesAddProductScreenState();
}

class _MySalesAddProductScreenState extends State<MySalesAddProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _desriptionController = TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _priceFocus = FocusNode();
  final FocusNode _discountFocus = FocusNode();
  final FocusNode _quantityFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();

  final salesHomeController = Get.put(MySalesController());

  final _formKey = GlobalKey<FormState>();
  bool isProductAdded = false;

  List<DropdownMenuItem> dropDownMenuItems = [
    DropdownMenuItem(
      value: "Men",
      child: Text(
        "Men",
        style: textStyle().copyWith(color: black),
      ),
    ),
    DropdownMenuItem(
      value: "Women",
      child: Text(
        "Women",
        style: textStyle(),
      ),
    ),
    DropdownMenuItem(
      value: "Kids",
      child: Text(
        "Kids",
        style: textStyle(),
      ),
    ),
    DropdownMenuItem(
      value: "Beauty",
      child: Text(
        "Beauty",
        style: textStyle(),
      ),
    ),
  ];

  String dropDownValue = "Men";
  List<XFile?> images = [];

  void pickMultiImages() async {
    images = await pickMultipleImages();
    setState(() {});
  }

  void checkStoragePermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      PermissionStatus permissionStatus = await Permission.storage.request();
      print("status is ${status.isGranted}");
    } else {
      pickMultiImages();
    }
  }

  void addProduct(String sales_id, String category, String shop_name) async {
    setState(() {
      isProductAdded = true;
    });
    await SalesProductService().addProduct(
      context: context,
      sales_id: sales_id,
      name: _nameController.text,
      description: _desriptionController.text,
      price: int.parse(_priceController.text),
      discount: int.parse(_discountController.text),
      quantity: int.parse(_quantityController.text),
      category: category,
      shop_name: shop_name,
      images: images,
      onSuccess: () {
        salesHomeController.getAllProducts(
            sales_id: sales_id, context: context);
        Navigator.pop(context);
        showSnackBar(context, "Product is added");
        setState(() {});
      },
    );
    setState(() {
      isProductAdded = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _priceController.dispose();
    _discountController.dispose();
    _quantityController.dispose();
    _desriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final salesman =
        Provider.of<SalesExecutiveProvider>(context, listen: false).user;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          "Add Product",
          style: textStyle().copyWith(
            color: black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                children: [
                  MyCustomTextField(
                    textEditingController: _nameController,
                    hintText: "Enter name",
                    labelText: "Name",
                    focusNode: _nameFocus,
                    fun: (p0) {
                      FocusScope.of(context).requestFocus(_priceFocus);
                    },
                  ),
                  Gap(15),
                  MyCustomTextField(
                    textEditingController: _priceController,
                    hintText: "Enter price",
                    labelText: "Price",
                    inputType: TextInputType.number,
                    focusNode: _priceFocus,
                    fun: (p0) {
                      FocusScope.of(context).requestFocus(_discountFocus);
                    },
                  ),
                  Gap(15),
                  MyCustomTextField(
                    textEditingController: _discountController,
                    hintText: "Enter Discount",
                    labelText: "Discount",
                    focusNode: _discountFocus,
                    inputType: TextInputType.number,
                    fun: (p0) {
                      FocusScope.of(context).requestFocus(_quantityFocus);
                    },
                  ),
                  Gap(15),
                  MyCustomTextField(
                    textEditingController: _quantityController,
                    hintText: "Enter quantity",
                    labelText: "Quantity",
                    focusNode: _quantityFocus,
                    inputType: TextInputType.number,
                    fun: (p0) {
                      FocusScope.of(context).requestFocus(_descriptionFocus);
                    },
                  ),
                  Gap(15),
                  MyCustomTextField(
                      textEditingController: _desriptionController,
                      hintText: "Enter Description",
                      labelText: "Description",
                      focusNode: _descriptionFocus),
                  Gap(15),
                  Row(
                    children: [
                      Gap(8),
                      Text(
                        "Category:",
                        style: textStyle().copyWith(color: black, fontSize: 18),
                      ),
                      Gap(20),
                      DropdownButton(
                        borderRadius: BorderRadius.circular(10),
                        items: dropDownMenuItems,
                        dropdownColor: white,
                        style: TextStyle(color: black),
                        onChanged: (value) {
                          setState(() {
                            dropDownValue = value;
                          });
                        },
                        value: dropDownValue,
                      ),
                    ],
                  ),
                  Gap(30),
                  GestureDetector(
                    onTap: checkStoragePermission,
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(10),
                      dashPattern: const [10, 4],
                      strokeCap: StrokeCap.round,
                      color: black,
                      child: Container(
                        width: double.infinity,
                        height: 210,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: images.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.folder_open,
                                    size: 40,
                                  ),
                                  Gap(15),
                                  Text(
                                    'Select Product Images',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade400),
                                  ),
                                ],
                              )
                            : CarouselSlider(
                                items: images.map((i) {
                                  return Builder(
                                      builder: (BuildContext context) =>
                                          Image.file(
                                            File(i!.path),
                                            fit: BoxFit.cover,
                                            height: 205,
                                          ));
                                }).toList(),
                                options: CarouselOptions(
                                    enableInfiniteScroll: false,
                                    autoPlay: true,
                                    autoPlayAnimationDuration:
                                        Duration(milliseconds: 1000),
                                    pauseAutoPlayOnTouch: true),
                              ),
                      ),
                    ),
                  ),
                  Gap(20),
                  GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate() &&
                            images.isNotEmpty) {
                          addProduct(
                              salesman.id, dropDownValue, salesman.shop_name);
                        } else if (images.isEmpty) {
                          showSnackBar(context, "Please choose images!");
                        }
                      },
                      child: MyAuthCustomButton(
                        color: indigo,
                        widget: isProductAdded
                            ? MyLoader(color: white)
                            : Text(
                                "ADD PRODUCT",
                                style: textStyle()
                                    .copyWith(fontSize: 15, color: white),
                              ),
                        textColor: white,
                        borderColor: indigo,
                      )),
                ],
              ),
            )),
      ),
    );
  }
}
