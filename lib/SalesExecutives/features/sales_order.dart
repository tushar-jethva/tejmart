import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final saler =
          Provider.of<SalesExecutiveProvider>(context, listen: false).user;
      getAllSalesProduct(saler.id);
    });
  }

  List<Map<String, dynamic>>? list;

  getAllSalesProduct(String sales_id) async {
    list = await SalesProductService()
        .getAllSalesProducts(context: context, seller_id: sales_id);
    setState(() {});
    print(list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list == null
          ? Center(
              child: MyLoader(color: indigo),
            )
          : GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: list!.length,
              itemBuilder: ((context, index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => MySalesDetailsScreen(
                                    produt: list![index]['product'],
                                    map: list![index],
                                  )));
                    },
                    child: MySalesOrderContainer(map: list![index]));
              })),
    );
  }
}
