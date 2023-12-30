// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tej_mart/constants/colors.dart';

class MyCircleAvatar extends StatelessWidget {
  final String url;
  final String name;
  final VoidCallback fun;
  const MyCircleAvatar({
    Key? key,
    required this.url,
    required this.name, required this.fun,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fun,
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
              url,
            ),
            radius: 30,
            backgroundColor: grey,
          ),
          Text(
            name,
            style: GoogleFonts.montserrat()
                .copyWith(color: black, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
