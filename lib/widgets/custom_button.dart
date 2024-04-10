// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tej_mart/constants/colors.dart';

class MyCustomButton extends StatelessWidget {
  final Color color;
  final String name;
  final Color textColor;
  final Color borderColor;
  const MyCustomButton(
      {Key? key,
      required this.color,
      required this.name,
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
        child: Text(
          name,
          style:
              GoogleFonts.montserrat().copyWith(color: textColor, fontSize: 15),
        ),
      ),
    );
  }
}
