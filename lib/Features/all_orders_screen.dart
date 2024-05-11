import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tej_mart/Features/order_details.dart';
import 'package:tej_mart/widgets/order_container.dart';

class MyAllOrdersScreen extends StatefulWidget {
  static const routeName = "/allOrders";
  final List<Map<String, dynamic>> list;  
  const MyAllOrdersScreen({super.key, required this.list});

  @override
  State<MyAllOrdersScreen> createState() => _MyAllOrdersScreenState();
}

class _MyAllOrdersScreenState extends State<MyAllOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
        title: Text(
          "Orders",
          style: GoogleFonts.montserrat(),
        ),
      ),
      body: GridView.builder(
          itemCount: widget.list.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, MyOrderDetails.routeName,
                    arguments: {"products": widget.list[index]});
              },
              child: MyOrderContainer(
                product: widget.list[index],
              ),
            );
          })),
    );
  }
}
