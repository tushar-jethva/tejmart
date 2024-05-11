import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:tej_mart/Features/all_orders_screen.dart';
import 'package:tej_mart/Features/homescreen.dart';
import 'package:tej_mart/Features/init_screen.dart';
import 'package:tej_mart/SalesExecutives/features/sales_all_orders_screen.dart';
import 'package:tej_mart/SalesExecutives/features/sales_details.dart';
import 'package:tej_mart/constants/sizes.dart';
import 'package:tej_mart/constants/style.dart';
import 'package:tej_mart/providers/salse_user_provider.dart';

import '../../constants/colors.dart';
import '../../constants/images_link.dart';
import '../../widgets/loader.dart';
import '../services/sales_prooduct_service.dart';
import '../widgets/sales_order_container.dart';

class MySalesProfileScreen extends StatefulWidget {
  const MySalesProfileScreen({super.key});

  @override
  State<MySalesProfileScreen> createState() => _MySalesProfileScreenState();
}

class _MySalesProfileScreenState extends State<MySalesProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final saler =
          Provider.of<SalesExecutiveProvider>(context, listen: false).user;
      getAcceptedSalesProduct(saler.id);
    });
  }

  List<Map<String, dynamic>>? list;
  getAcceptedSalesProduct(String sales_id) async {
    list = await SalesProductService()
        .getAllAcceptedSalesProducts(context: context, seller_id: sales_id);
    setState(() {});
    print(list);
  }

  @override
  Widget build(BuildContext context) {
    final sales = Provider.of<SalesExecutiveProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Welcome ${sales.name}",
          style: textStyle(),
        ),
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, MyInitScreen.routeName, (route) => false);
              },
              child: Icon(Icons.logout))
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
                sales.name,
                style: textStyle().copyWith(color: black),
              )
            ],
          ),
          Gap(getHeight(0.03, context)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(0.03, context)),
            child: MyHeaderText(
              leftText: "Completed Orders",
              rightText: "See all",
              fontSize: 20,
              onRightTap: () {
                Navigator.pushNamed(context, MySalesAllOrdersScreen.routeName,
                    arguments: list);
              },
            ),
          ),
          Gap(getHeight(0.01, context)),
          list == null
              ? Center(
                  child: MyLoader(color: indigo),
                )
              : SizedBox(
                  height: 200,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: list!.length > 3 ? 3 : list!.length,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => MySalesDetailssScreen(
                                            produt: list![index]['product'],
                                            map: list![index],
                                            isCompleted: true,
                                          )));
                            },
                            child: MySalesOrderContainer(map: list![index]));
                      })),
                ),
        ],
      ),
    );
  }
}
