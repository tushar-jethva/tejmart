
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tej_mart/SalesExecutives/models/sales_addProduct.dart';
import 'package:tej_mart/SalesExecutives/services/sales_prooduct_service.dart';

import '../../providers/salse_user_provider.dart';

class MySalesAnalyticalScreen extends StatefulWidget {
  const MySalesAnalyticalScreen({super.key});

  @override
  State<MySalesAnalyticalScreen> createState() =>
      _MySalesAnalyticalScreenState();
}

class _MySalesAnalyticalScreenState extends State<MySalesAnalyticalScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final saler =
          Provider.of<SalesExecutiveProvider>(context, listen: false).user;
      getSalesWiseItems(saler.id);
    });
  }

  List<SalesAddProductModel>? list;
  getSalesWiseItems(String sales_id) async {
    list = await SalesProductService()
        .products(context: context, sales_id: sales_id);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
