import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tej_mart/SalesExecutives/features/sales_details_screen.dart';
import 'package:tej_mart/SalesExecutives/widgets/sales_order_container.dart';
import 'package:tej_mart/SalesExecutives/features/sales_details.dart';

class MySalesAllOrdersScreen extends StatefulWidget {
  static const routeName = '/salesAllOrders';
  final List<Map<String, dynamic>> list;
  const MySalesAllOrdersScreen({super.key, required this.list});

  @override
  State<MySalesAllOrdersScreen> createState() => _MySalesAllOrdersScreenState();
}

class _MySalesAllOrdersScreenState extends State<MySalesAllOrdersScreen> {
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
          "Completed Orders",
          style: GoogleFonts.montserrat(),
        ),
      ),
      body: GridView.builder(
          itemCount: widget.list.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => MySalesDetailssScreen(
                              produt: widget.list![index]['product'],
                              map: widget.list![index],
                              isCompleted: true,
                            )));
              },
              child: MySalesOrderContainer(
                map: widget.list[index],
              ),
            );
          })),
    );
  }
}
