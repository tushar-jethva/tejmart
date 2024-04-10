// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:tej_mart/constants/colors.dart';

class MyQuantityWidget extends StatefulWidget {
  int number;
  MyQuantityWidget({
    Key? key,
    required this.number,
  }) : super(key: key);

  @override
  State<MyQuantityWidget> createState() => _MyQuantityWidgetState();
}

class _MyQuantityWidgetState extends State<MyQuantityWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(255, 240, 240, 240),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
              onTap: () {
                if (widget.number > 0) {
                  widget.number--;
                  setState(() {});
                }
              },
              child: Icon(Icons.minimize_outlined)),
          Text(widget.number.toString()),
          GestureDetector(
              onTap: () {
                widget.number++;
                setState(() {});
              },
              child: Icon(Icons.add))
        ],
      ),
    );
  }
}
