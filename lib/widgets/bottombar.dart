import 'package:flutter/material.dart';
import 'package:tej_mart/Features/cartscreen.dart';
import 'package:tej_mart/Features/favourite_screen.dart';
import 'package:tej_mart/Features/homescreen.dart';
import 'package:tej_mart/Features/profile_screen.dart';
import 'package:tej_mart/constants/colors.dart';
import 'package:fluentui_icons/fluentui_icons.dart';

class MyBottomBar extends StatefulWidget {
  static const routeName = '/customeBottom';
  const MyBottomBar({super.key});

  @override
  State<MyBottomBar> createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  int currIndex = 0;
  List<Widget> screens = [
    MyHomeScreen(),
    MyFavouriteScreen(),
    MyProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
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
                Icons.favorite,
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
