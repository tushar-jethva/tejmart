import 'package:flutter/material.dart';
import 'package:tej_mart/constants/colors.dart';

class MyDeleteButton extends StatelessWidget {
  const MyDeleteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        decoration: BoxDecoration(
          color: Color.fromARGB(53, 242, 15, 38),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text("Delete"));
  }
}
