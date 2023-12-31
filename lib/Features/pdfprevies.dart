import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

import 'package:tej_mart/Features/invoice.dart';
import 'package:tej_mart/providers/customer_provider.dart';

class PdfPreviewS extends StatelessWidget {
  final Map<String, dynamic> map;
  const PdfPreviewS({
    Key? key,
    required this.map,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomerProvider>(context).user;
    return Scaffold(
      body:
          PdfPreview(build: (context) => MyInvoiceScreen().makePdf(map, user)),
    );
  }
}
