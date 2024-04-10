// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tej_mart/constants/colors.dart';

class MySearchBar extends StatelessWidget {
  final String name;
  const MySearchBar({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      width: double.infinity,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: TextField(
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          cursorColor: indigo,
          style: GoogleFonts.montserrat(),
          decoration: InputDecoration(
            hintText: "Search $name's fashion...",
            hintStyle: GoogleFonts.montserrat(),
            prefixIcon: Icon(
              Icons.search,
              color: black,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: black),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: black),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: indigo),
            ),
            contentPadding: const EdgeInsets.only(top: 1),
          ),
        ),
      ),
    );
  }
}
