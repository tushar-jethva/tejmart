// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:tej_mart/constants/colors.dart';

class MyOneCarousel extends StatelessWidget {
  final String image;
  const MyOneCarousel({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: grey,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: CachedNetworkImageProvider(image), fit: BoxFit.cover)),
    );
  }
}
