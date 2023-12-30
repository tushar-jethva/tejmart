// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tej_mart/constants/colors.dart';

class MyCustomTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final String labelText;
  final bool isPassword;
  final FocusNode focusNode;
  final Function(String)? fun;
  final TextInputType inputType;
  const MyCustomTextField({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    required this.labelText,
    this.isPassword = false,
    required this.focusNode,
    this.inputType = TextInputType.name,
    this.fun,
  }) : super(key: key);

  @override
  State<MyCustomTextField> createState() => _MyCustomTextFieldState();
}

class _MyCustomTextFieldState extends State<MyCustomTextField> {
  bool isShow = false;
  @override
  Widget build(BuildContext context) {
    return !widget.isPassword
        ? TextFormField(
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            onFieldSubmitted: widget.fun,
            focusNode: widget.focusNode,
            controller: widget.textEditingController,
            keyboardType: widget.inputType,
            style: GoogleFonts.montserrat(),
            decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: GoogleFonts.montserrat().copyWith(color: grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: blue, width: 1),
                ),
                labelText: widget.labelText),
            validator: (value) {
              if (value!.isEmpty) {
                return widget.hintText;
              }
            },
          )
        : TextFormField(
            onFieldSubmitted: widget.fun,
            focusNode: widget.focusNode,
            controller: widget.textEditingController,
            style: GoogleFonts.montserrat(),
            obscureText: isShow,
            decoration: InputDecoration(
                suffixIcon: GestureDetector(
                    onTap: () {
                      isShow = !isShow;
                      setState(() {});
                    },
                    child: isShow
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility)),
                hintText: widget.hintText,
                hintStyle: GoogleFonts.montserrat().copyWith(color: grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: blue, width: 1),
                ),
                labelText: widget.labelText),
            validator: (value) {
              if (value!.isEmpty || value == null) {
                return widget.hintText;
              }
            },
          );
  }
}
