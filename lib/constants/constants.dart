import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tej_mart/constants/style.dart';
import 'package:pdf/widgets.dart' as pw;

// String url = 'https://tej-mart.onrender.com';
String url = 'http://192.168.90.230:3000';

Future<List<XFile?>> pickMultipleImages() async {
  List<XFile?> images = await ImagePicker().pickMultiImage(
    imageQuality: 30,
  );
  return images;
}

void showSnackBar(BuildContext context, String data) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        data,
        style: textStyle(),
      ),
    ),
  );
}

pw.Widget PaddedText(
  final String text, {
  final pw.TextAlign align = pw.TextAlign.left,
}) =>
    pw.Padding(
      padding: pw.EdgeInsets.all(10),
      child: pw.Text(
        text,
        textAlign: align,
      ),
    );
