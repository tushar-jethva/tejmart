import 'package:flutter/widgets.dart';
import 'package:tej_mart/SalesExecutives/models/sales_addProduct.dart';
import 'package:tej_mart/services/cart_service.dart';

class CartProvider with ChangeNotifier {
  List<SalesAddProductModel> _list = [];
  List<SalesAddProductModel> get list => _list;
  bool isLoading = false;
}
