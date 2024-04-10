import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:tej_mart/SalesExecutives/models/sales_addProduct.dart';
import 'package:tej_mart/constants/colors.dart';
import 'package:tej_mart/constants/constants.dart';
import 'package:tej_mart/constants/style.dart';
import 'package:tej_mart/models/user_model.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class MyInvoiceScreen {
  Future<Uint8List> makePdf(Map<String, dynamic> map, UserModel user) async {
    var dateAndTime =
        DateTime.fromMillisecondsSinceEpoch(map['products']['orderAt']);
    var d12 = DateFormat('dd/MM/yyyy').format(dateAndTime);
    print(map);
    final pdf = pw.Document();
    pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw
          .Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
          pw.Text("TEJMart",
              style: pw.TextStyle(
                fontSize: 30,
                fontWeight: pw.FontWeight.bold,
              )),
          pw.Text("Invoice/Bill of Supply/Cash Memo",
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold))
        ]),
        pw.SizedBox(height: 100),
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
          pw.Text("Order Date: ${d12}",
              style: pw.TextStyle(
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
              )),
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.end, children: [
            pw.Text("Shipping Address:",
                style:
                    pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
            pw.Text(
              user.address,
            ),
            pw.SizedBox(
              height: 20,
            ),
            pw.Text("MobileNo:",
                style:
                    pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
            pw.Text(
              "${user.mobile_no}",
            )
          ])
        ]),
        pw.SizedBox(height: 200),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.black),
          columnWidths: {
            0: pw.FlexColumnWidth(7),
            1: pw.FlexColumnWidth(50),
            2: pw.FlexColumnWidth(15),
            3: pw.FlexColumnWidth(17),
          },
          children: [
            pw.TableRow(
              children: [
                pw.Text("No.", textAlign: pw.TextAlign.center),
                pw.Text("Product Name", textAlign: pw.TextAlign.center),
                pw.Text("Quantity", textAlign: pw.TextAlign.center),
                pw.Text("Price", textAlign: pw.TextAlign.center)
              ],
            ),
          ],
        ),
        pw.ListView.builder(
          itemCount: map['products']['product'].length,
          itemBuilder: (context, index) {
            SalesAddProductModel obj =
                map['products']['product'][index]['product'];

            double price = obj.price * (1 - (obj.discount / 100.00));
            return pw.Table(
                columnWidths: {
                  0: pw.FlexColumnWidth(7),
                  1: pw.FlexColumnWidth(50),
                  2: pw.FlexColumnWidth(15),
                  3: pw.FlexColumnWidth(17),
                },
                border: pw.TableBorder.all(color: PdfColors.black),
                children: [
                  pw.TableRow(children: [
                    pw.Expanded(
                        child: PaddedText((index + 1).toString()), flex: 1),
                    pw.Expanded(child: PaddedText(obj.name)),
                    pw.Expanded(
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(10),
                        child: pw.Text(
                          "x${map['products']['product'][index]['quantity_product'].toString()}",
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                    ),
                    pw.Expanded(
                        child: PaddedText(
                            "${(map['products']['product'][index]['quantity_product'] * price).toString()}\$")),
                  ]),
                ]);
          },
        ),
        pw.Table(
            columnWidths: {
              0: pw.FlexColumnWidth(72),
              1: pw.FlexColumnWidth(17),
            },
            border: pw.TableBorder.all(color: PdfColors.black),
            children: [
              pw.TableRow(children: [
                pw.Expanded(
                  child: pw.Padding(
                    padding: pw.EdgeInsets.all(10),
                    child: pw.Text(
                      "Total Amount",
                      textAlign: pw.TextAlign.right,
                    ),
                  ),
                ),
                pw.Expanded(
                    child: PaddedText(
                        "${map['products']['total_amount'].toString()}\$"))
              ])
            ]),
        pw.Text("Thank you for shopping!",
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold))
      ]);
    }));

    // On Flutter, use the [path_provider](https://pub.dev/packages/path_provider) library:
    final output = await getApplicationDocumentsDirectory();
    print(output);
    final file = File("${output.path}/invoice.pdf");
    // print(file);
    File f = await file.writeAsBytes(await pdf.save());
    print(base64Encode(f.readAsBytesSync()));

    return pdf.save();
  }
}
