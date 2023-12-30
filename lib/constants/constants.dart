import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tej_mart/constants/style.dart';

String url = 'http://192.168.137.229:3000';

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
