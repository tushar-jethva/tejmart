// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tej_mart/Features/profile_screen.dart';
import 'package:tej_mart/SalesExecutives/features/analytical.dart';

import 'package:tej_mart/SalesExecutives/features/sales_homescreen.dart';
import 'package:tej_mart/SalesExecutives/features/sales_order.dart';
import 'package:tej_mart/SalesExecutives/features/sales_profile.dart';
import 'package:tej_mart/providers/salse_user_provider.dart';

import '../../constants/colors.dart';

class MySalesBottomBar extends StatefulWidget {
  static const routeName = '/salesBottom';
  final Map<String, String> map;
  const MySalesBottomBar({
    Key? key,
    required this.map,
  }) : super(key: key);

  @override
  State<MySalesBottomBar> createState() => _MySalesBottomBarState();
}

class _MySalesBottomBarState extends State<MySalesBottomBar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int currIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      MySalesHomeScreen(
        sales_id: widget.map['sales_id']!,
      ),
    
      MySalesOrderScreen(),
      MySalesProfileScreen(),
    ];
    return Scaffold(
      body: Center(
        child: screens[currIndex],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: indigo,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  currIndex = 0;
                });
              },
              child: Icon(
                Icons.home_filled,
                color: white,
              ),
            ),
            
            GestureDetector(
              onTap: () {
                setState(() {
                  currIndex = 1;
                });
              },
              child: Icon(
                Icons.all_inbox_outlined,
                color: white,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  currIndex = 2;
                });
              },
              child: Icon(
                Icons.person,
                color: white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
