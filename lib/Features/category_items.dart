// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tej_mart/Features/details_screen.dart';
import 'package:tej_mart/SalesExecutives/models/sales_addProduct.dart';
import 'package:tej_mart/constants/colors.dart';
import 'package:tej_mart/services/product_service.dart';
import 'package:tej_mart/widgets/category_contaier.dart';
import 'package:tej_mart/widgets/loader.dart';

class MyCategoryList extends StatefulWidget {
  static const routeName = '/categoryList';
  Map<String, String> map;
  MyCategoryList({
    Key? key,
    required this.map,
  }) : super(key: key);

  @override
  State<MyCategoryList> createState() => _MyCategoryListState();
}

class _MyCategoryListState extends State<MyCategoryList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryProducts(widget.map['name']!);
  }

  List<SalesAddProductModel>? list;

  getCategoryProducts(String category) async {
    list = await CustomerProductService()
        .getCategoryWiseProduct(context: context, category: category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.map['name']!,
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: list == null
          ? Center(child: MyLoader(color: indigo))
          : Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 10),
              child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: list!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    mainAxisExtent: 200,
                  ),
                  itemBuilder: (context, index) {
                    double discountedPrice = list![index].price *
                        (1 - (list![index].discount / 100.00));
                    return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, MyDetailsScreen.routeName, arguments: {
                            "product": list![index],
                            "name": widget.map['name']
                          });
                        },
                        child: MyCategoryContainer(
                            itemName: list![index].name,
                            url: list![index].images[0],
                            price: discountedPrice));
                  }),
            ),
    );
  }
}
