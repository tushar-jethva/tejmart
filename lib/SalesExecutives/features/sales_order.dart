import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:tej_mart/SalesExecutives/controllers/sales_home_controller.dart';
import 'package:tej_mart/SalesExecutives/features/sales_details.dart';
import 'package:tej_mart/SalesExecutives/services/sales_prooduct_service.dart';
import 'package:tej_mart/SalesExecutives/widgets/sales_order_container.dart';
import 'package:tej_mart/constants/colors.dart';
import 'package:tej_mart/providers/salse_user_provider.dart';
import 'package:tej_mart/widgets/loader.dart';

class MySalesOrderScreen extends StatefulWidget {
  const MySalesOrderScreen({super.key});

  @override
  State<MySalesOrderScreen> createState() => _MySalesOrderScreenState();
}

class _MySalesOrderScreenState extends State<MySalesOrderScreen> {
  final salesHomeController = Get.put(MySalesController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final saler =
          Provider.of<SalesExecutiveProvider>(context, listen: false).user;
      salesHomeController.getAllSalesProduct(
          context: context, sales_id: saler.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: salesHomeController.listOfIncomingOrders.isEmpty
            ? const Center(
                child: Text("No Orders found!"),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: salesHomeController.listOfIncomingOrders.length,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => MySalesDetailssScreen(
                                      produt: salesHomeController
                                              .listOfIncomingOrders[index]
                                          ['product'],
                                      map: salesHomeController
                                          .listOfIncomingOrders[index],
                                    )));
                      },
                      child: MySalesOrderContainer(
                          map:
                              salesHomeController.listOfIncomingOrders[index]));
                })),
      ),
    );
  }
}
