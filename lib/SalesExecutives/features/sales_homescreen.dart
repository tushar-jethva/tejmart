// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tej_mart/Features/details_screen.dart';

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllProducts();
  }

  List<SalesAddProductModel>? list;

  Future<void> getAllProducts() async {
    print(widget.sales_id);
    list = await SalesProductService()
        .getAllProducts(context: context, sales_id: widget.sales_id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list == null
          ? MyLoader(color: indigo)
          : RefreshIndicator(
              onRefresh: getAllProducts,
              child: GridView.builder(
                  itemCount: list!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, MySalesDetailsScreen.routeName,
                              arguments: {"product": list![index]});
                        },
                        child: MyTrendingContainer(
                          itemName: list![index].name,
                          forName: list![index].category,
                          price: list![index].price,
                          url: list![index].images[0],
                        ),
                      ),
                    );
                  })),
            ),
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
    );
  }
}
