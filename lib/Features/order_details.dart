// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tej_mart/Features/invoice.dart';
import 'package:tej_mart/Features/pdfprevies.dart';
import 'package:tej_mart/SalesExecutives/models/sales_addProduct.dart';
import 'package:tej_mart/constants/colors.dart';
import 'package:tej_mart/constants/sizes.dart';
import 'package:tej_mart/constants/style.dart';
import 'package:tej_mart/widgets/one_order_detail_container.dart';

class MyOrderDetails extends StatefulWidget {
  static const routeName = "/orderdetails";
  final Map<String, dynamic> product;
  const MyOrderDetails({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<MyOrderDetails> createState() => _MyOrderDetailsState();
}

class _MyOrderDetailsState extends State<MyOrderDetails> {
  List<SalesAddProductModel> list = [];

  @override
  Widget build(BuildContext context) {
    // print(widget.product);
    int quantity = 0;
    for (int i = 0; i < widget.product['products']['product'].length; i++) {
      list.add(widget.product['products']['product'][i]['product']);
      String s = widget.product['products']['product'][i]['quantity_product']
          .toString();
      quantity += int.parse(s);
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(30),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back_ios_new),
                    ),
                    Gap(getWidth(0.03, context)),
                    Text(
                      "Total Items ${quantity}",
                      style: textStyle().copyWith(color: black, fontSize: 20),
                    ),
                  ],
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => PdfPreviewS(
                                map: widget.product,
                              )));
                    },
                    child: Text(
                      "Invoice",
                      style: textStyle().copyWith(
                          color: indigo,
                          decoration: TextDecoration.underline,
                          fontSize: 16),
                    ))
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  double price =
                      list[index].price * (1 - (list[index].discount / 100.00));
                  String data = "";

                  return MySignleOrderDetailsContainer(
                    name: list[index].name,
                    price: price.toString(),
                    image: list[index].images[0],
                    quantity: widget.product['products']['product'][index]
                        ['quantity_product'],
                    status: widget.product['products']['product'][index]
                        ['status'],
                  );
                }),
          )
        ],
      ),
    );
  }
}
