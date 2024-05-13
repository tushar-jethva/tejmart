import 'package:flutter/material.dart';

double getHeight(double height, BuildContext context) {
  return MediaQuery.of(context).size.height * height;
}

double getWidth(double width, BuildContext context) {
  return MediaQuery.of(context).size.width * width;
}
