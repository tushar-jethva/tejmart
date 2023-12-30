// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tej_mart/constants/colors.dart';

class MyAuthCustomButton extends StatelessWidget {
  final Color color;
  final Widget widget;
  final Color textColor;
  final Color borderColor;
  const MyAuthCustomButton(
      {Key? key,
      required this.color,
      required this.widget,
      required this.textColor,
      required this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor, width: 0.8)),
      child: Center(
        child: widget
      ),
    );
  }
}
