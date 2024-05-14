// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tej_mart/Features/details_screen.dart';
import 'package:tej_mart/SalesExecutives/controllers/sales_home_controller.dart';
import 'package:tej_mart/SalesExecutives/features/sales_additem.dart';
import 'package:tej_mart/SalesExecutives/features/sales_details_screen.dart';
import 'package:tej_mart/SalesExecutives/models/sales_addProduct.dart';
import 'package:tej_mart/SalesExecutives/services/sales_prooduct_service.dart';
import 'package:tej_mart/constants/colors.dart';
import 'package:tej_mart/providers/salse_user_provider.dart';
import 'package:tej_mart/widgets/loader.dart';
import 'package:tej_mart/widgets/trending_container.dart';

class MySalesHomeScreen extends StatefulWidget {
  static const routeName = '/salesHome';
  final String sales_id;
  const MySalesHomeScreen({
    Key? key,
    required this.sales_id,
  }) : super(key: key);

  @override
  State<MySalesHomeScreen> createState() => _MySalesHomeScreenState();
}

class _MySalesHomeScreenState extends State<MySalesHomeScreen> {
  final salesHomeController = Get.put(MySalesController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getAllProducts();
    salesHomeController.getAllProducts(
        sales_id: widget.sales_id, context: context);
  }

  // List<SalesAddProductModel>? list;

  // Future<void> getAllProducts() async {
  //   print(widget.sales_id);
  //   list = await SalesProductService()
  //       .getAllProducts(context: context, sales_id: widget.sales_id);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: salesHomeController.list.isEmpty
            ? Center(child: MyLoader(color: indigo))
            : GridView.builder(
                itemCount: salesHomeController.list.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, MySalesDetailsScreen.routeName,
                            arguments: {
                              "product": salesHomeController.list[index]
                            });
                      },
                      child: MyTrendingContainer(
                        itemName: salesHomeController.list[index].name,
                        forName: salesHomeController.list[index].category,
                        price: salesHomeController.list[index].price,
                        url: salesHomeController.list[index].images[0],
                      ),
                    ),
                  );
                })),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              MySalesAddProductScreen.routeName,
            );
          },
          child: Icon(
            Icons.add,
            color: white,
          ),
          backgroundColor: indigo,
        ),
      ),
    );
  }
}
