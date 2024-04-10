import 'package:flutter/material.dart';

class MyBottomDots extends StatelessWidget {
  final int dots;
  const MyBottomDots({super.key, required this.dots});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            dots,
            (index) => Container(
                  padding: const EdgeInsets.all(3),
                  child: Container(
                    width: 8,
                    height: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black),
                  ),
                )));
  }
}
