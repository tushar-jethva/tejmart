// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';
import '../constants/images_link.dart';

class MyCategoryContainer extends StatelessWidget {
  final String itemName;
  final String url;
  final double price;
  const MyCategoryContainer({
    Key? key,
    required this.itemName,
    required this.url,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      width: 160,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 240, 240, 240),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 120,
                width: 179,
                margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(url),
                        fit: BoxFit.cover)),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, top: 5),
            child: Text(
              itemName,
              maxLines: 2,
              style: GoogleFonts.montserrat().copyWith(
                  color: black,
                  fontWeight: FontWeight.w900,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              "\$${price.toStringAsFixed(2)}",
              style: GoogleFonts.montserrat().copyWith(
                  color: priceColor, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
