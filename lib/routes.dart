import 'package:flutter/material.dart';
import 'package:tej_mart/Features/buyscree.dart';
import 'package:tej_mart/Features/cartscreen.dart';
import 'package:tej_mart/Features/category_items.dart';
import 'package:tej_mart/Features/details_screen.dart';
import 'package:tej_mart/Features/favourite_screen.dart';
import 'package:tej_mart/Features/homescreen.dart';
import 'package:tej_mart/Features/init_screen.dart';
import 'package:tej_mart/Features/order_details.dart';
import 'package:tej_mart/Features/profile_screen.dart';
import 'package:tej_mart/Features/sign_up.dart';
import 'package:tej_mart/Features/signin.dart';
import 'package:tej_mart/SalesExecutives/features/sales_additem.dart';
import 'package:tej_mart/SalesExecutives/features/sales_bottom_bar.dart';
import 'package:tej_mart/SalesExecutives/features/sales_details_screen.dart';
import 'package:tej_mart/SalesExecutives/features/sales_sign_in.dart';
import 'package:tej_mart/SalesExecutives/features/sales_sign_up.dart';
import 'package:tej_mart/widgets/bottombar.dart';
import 'package:tej_mart/widgets/category_contaier.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case MySignInScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => const MySignInScreen(), settings: routeSettings);

    case MySignUpScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => const MySignUpScreen(), settings: routeSettings);

    case MySalesSignIn.routeName:
      return MaterialPageRoute(
          builder: (_) => const MySalesSignIn(), settings: routeSettings);

    case MySalesSignUpScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => const MySalesSignUpScreen(), settings: routeSettings);

    case MyInitScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => const MyInitScreen(), settings: routeSettings);

    case MyHomeScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => const MyHomeScreen(), settings: routeSettings);

    case MyCategoryList.routeName:
      Map<String, String> map = routeSettings.arguments as Map<String, String>;
      return MaterialPageRoute(
          builder: (_) => MyCategoryList(
                map: map,
              ),
          settings: routeSettings);

    case MyDetailsScreen.routeName:
      Map<String, dynamic> map =
          routeSettings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
          builder: (_) => MyDetailsScreen(map: map), settings: routeSettings);

    case MySalesDetailsScreen.routeName:
      Map<String, dynamic> map =
          routeSettings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
          builder: (_) => MySalesDetailsScreen(map: map),
          settings: routeSettings);

    case MyCartScreen.routeName:
      Map<String, String> map = routeSettings.arguments as Map<String, String>;
      return MaterialPageRoute(
          builder: (_) => MyCartScreen(map: map), settings: routeSettings);

    case MySalesAddProductScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => MySalesAddProductScreen(), settings: routeSettings);

    case MySalesBottomBar.routeName:
      Map<String, String> map = routeSettings.arguments as Map<String, String>;
      return MaterialPageRoute(
          builder: (_) => MySalesBottomBar(
                map: map,
              ),
          settings: routeSettings);

    case MyBottomBar.routeName:
      return MaterialPageRoute(
          builder: (_) => MyBottomBar(), settings: routeSettings);

    case MyBuyScreen.routeName:
      Map<String, dynamic> map =
          routeSettings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
          builder: (_) => MyBuyScreen(
                map: map,
              ),
          settings: routeSettings);

    case MyFavouriteScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => MyFavouriteScreen(), settings: routeSettings);

    case MyProfileScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => MyProfileScreen(), settings: routeSettings);

    case MyOrderDetails.routeName:
      Map<String, dynamic> map =
          routeSettings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
          builder: (_) => MyOrderDetails(
                product: map,
              ),
          settings: routeSettings);

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(child: Text("Page not found")),
        ),
      );
  }
}
