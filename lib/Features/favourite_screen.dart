import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tej_mart/SalesExecutives/models/sales_addProduct.dart';
import 'package:tej_mart/constants/colors.dart';
import 'package:tej_mart/providers/customer_provider.dart';
import 'package:tej_mart/services/favouritescreen.dart';
import 'package:tej_mart/widgets/cart_item.dart';
import 'package:tej_mart/widgets/loader.dart';
import 'package:tej_mart/widgets/onefavourite.dart';

class MyFavouriteScreen extends StatefulWidget {
  static const routeName = 'favourite';
  const MyFavouriteScreen({super.key});

  @override
  State<MyFavouriteScreen> createState() => _MyFavouriteScreenState();
}

class _MyFavouriteScreenState extends State<MyFavouriteScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final user = Provider.of<CustomerProvider>(context, listen: false).user;
      getAllWishlistProduct(user.id);
    });
  }

  List<SalesAddProductModel>? product;
  void getAllWishlistProduct(String user_id) async {
    product = await FavouriteService()
        .getAllWishListProduct(context: context, user_id: user_id);
    setState(() {});
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: product == null
          ? Center(
              child: MyLoader(color: indigo),
            )
          : ListView.builder(
              itemCount: product!.length,
              itemBuilder: (context, index) {
                return MyOneFavourite(product: product![index]);
              }),
    );
  }
}
