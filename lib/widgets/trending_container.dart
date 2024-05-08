// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tej_mart/constants/colors.dart';
import 'package:tej_mart/constants/images_link.dart';

class MyTrendingContainer extends StatelessWidget {
  final String itemName;
  final String forName;
  final int price;
  final String url;
  const MyTrendingContainer({
    Key? key,
    required this.itemName,
    required this.forName,
    required this.price,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
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
                margin: EdgeInsets.only(top: 7, left: 7, right: 7),
                height: 120,
                width: 160,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(url),
                        fit: BoxFit.cover)),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10),
            child: Text(
              itemName,
              maxLines: 1,
              style: GoogleFonts.montserrat().copyWith(
                  color: black,
                  fontWeight: FontWeight.w900,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "For ${forName}",
                  style: GoogleFonts.montserrat().copyWith(
                      color: grey, fontWeight: FontWeight.bold, fontSize: 12),
                ),
                Text(
                  "\$${price.toStringAsFixed(2)}",
                  style: GoogleFonts.montserrat().copyWith(
                      color: priceColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
