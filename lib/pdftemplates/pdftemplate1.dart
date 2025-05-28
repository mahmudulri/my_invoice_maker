import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:invoice_maker/invoicecontrollers/new_items_controller.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../invoicecontrollers/address_controller.dart';
import '../invoicecontrollers/billto_controller.dart';
import '../invoicecontrollers/invoice_data_controller.dart';
import '../invoicecontrollers/item_list_controller.dart';

final BusinessAddressController businessAddressController = Get.put(
  BusinessAddressController(),
);

final BilltoController billtoController = Get.put(BilltoController());
InvoiceDataController invoiceDataController = Get.put(InvoiceDataController());

class PdfTemplate1 {
  Future<Uint8List> generatePDF() async {
    final pdf = pw.Document();
    List<pw.Widget> widgets = [];
    final statusimgae = (await rootBundle
            .load(invoiceDataController.imagelink.value.toString()))
        .buffer
        .asUint8List();
    final logo =
        (await rootBundle.load("assets/icons/logo.png")).buffer.asUint8List();

    final sstatusarea = pw.Container(
      height: 120,
      width: 120,
      child: pw.Image(pw.MemoryImage(statusimgae), height: 60),
    );

    final statusarea = pw.Transform.rotate(
      angle: 25 * 3.1415927 / 170, // Rotate by 45 degrees in radians
      child: pw.Container(
        height: 150,
        width: 150,
        child: pw.Image(
          pw.MemoryImage(statusimgae),
          height: 60,
        ),
      ),
    );

    final headerarea = pw.Container(
      height: 60,
      color: PdfColors.white,
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // pw.Image(pw.MemoryImage(logo), height: 60),
          pw.Container(
            width: 200,
            // color: PdfColors.red,
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  "INVOICE",
                  style: pw.TextStyle(
                    fontSize: 35,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          pw.SizedBox(
            width: 50,
          ),

          pw.Container(
            width: 250,
            // color: PdfColors.green,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Row(
                  children: [
                    pw.Text(
                      "ID :",
                      style: pw.TextStyle(
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Spacer(),
                    pw.Text(
                      "INV00001",
                      style: pw.TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text(
                      "Date :",
                      style: pw.TextStyle(
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Spacer(),
                    pw.Text(
                      "29-Apr-2025",
                      style: pw.TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
    final divider = pw.Divider(
      thickness: 1,
      color: PdfColors.grey,
    );
    final addressArea = pw.Container(
      height: 110,
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          // pw.Image(pw.MemoryImage(logo), height: 60),
          pw.Container(
            width: 230,
            // color: PdfColors.red,
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  "FROM",
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  businessAddressController.businessNameController.text
                      .toString(),
                  style: pw.TextStyle(
                    fontSize: 15,
                  ),
                ),
                pw.Text(
                  businessAddressController.address1Controller.text.toString(),
                  style: pw.TextStyle(
                    fontSize: 15,
                  ),
                ),
                pw.Text(
                  businessAddressController.address2Controller.text.toString(),
                  style: pw.TextStyle(
                    fontSize: 15,
                  ),
                ),
                pw.Text(
                  businessAddressController.phoneNumberController.text
                      .toString(),
                  style: pw.TextStyle(
                    fontSize: 15,
                  ),
                ),
                pw.Text(
                  businessAddressController.websiteController.text.toString(),
                  style: pw.TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          pw.SizedBox(
            width: 50,
          ),

          pw.Container(
            width: 250,
            // color: PdfColors.green,
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  "To",
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  billtoController.nameController.text.toString(),
                  style: pw.TextStyle(
                    fontSize: 15,
                  ),
                ),
                pw.Text(
                  billtoController.address1Controller.text.toString(),
                  style: pw.TextStyle(
                    fontSize: 15,
                  ),
                ),
                pw.Text(
                  billtoController.address2Controller.text.toString(),
                  style: pw.TextStyle(
                    fontSize: 15,
                  ),
                ),
                pw.Text(
                  billtoController.phoneNumberController.text.toString(),
                  style: pw.TextStyle(
                    fontSize: 15,
                  ),
                ),
                pw.Text(
                  billtoController.websiteController.text.toString(),
                  style: pw.TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    final totaprice = pw.Container(
      height: 90,
      // color: PdfColors.grey.shade(0.20),
      child: pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Text(
                "Sub Total :",
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              // pw.SizedBox(width: 40),
              pw.Container(
                width: 120,
                child: pw.Text(
                  itemListController.subTotalPrice.toString(),
                  textAlign: pw.TextAlign.right,
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Text(
                "Discount :",
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Container(
                width: 120,
                child: pw.Text(
                  itemListController.discountedPrice.toString(),
                  textAlign: pw.TextAlign.right,
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Text(
                "Tax :",
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Container(
                width: 120,
                child: pw.Text(
                  itemListController.taxmount.toString(),
                  textAlign: pw.TextAlign.right,
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          // pw.Divider(
          //   thickness: 1,
          //   color: PdfColors.grey,
          // ),
          pw.SizedBox(height: 3),
          pw.Container(
            height: 1,
            width: double.infinity,
            color: PdfColors.grey.shade(0.20),
          ),
          pw.SizedBox(height: 3),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Text(
                "Total :",
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Container(
                width: 120,
                child: pw.Text(
                  itemListController.totalPrice.toString(),
                  textAlign: pw.TextAlign.right,
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    final footerarea = pw.Container(
      height: 5,
      color: PdfColors.grey.shade(0.20),
      child: pw.Row(
        children: [],
      ),
    );
    final gap15 = pw.SizedBox(height: 15);
    final gap150 = pw.SizedBox(height: 250);
    final fullgap = pw.Expanded(
      flex: 1,
      fit: pw.FlexFit.tight,
      child: pw.Container(),
    );

    widgets.add(headerarea);
    widgets.add(divider);
    widgets.add(addressArea);
    widgets.add(gap15);
    widgets.add(table());

    widgets.add(gap150);
    widgets.add(totaprice);
    widgets.add(statusarea);

    widgets.add(fullgap);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 25,
        ), // <<< REMOVE ALL MARGIN
        build: (pw.Context context) {
          return widgets;
        },
      ),
    );

    return pdf.save();
  }

  final ItemListController itemListController = Get.put(
    ItemListController(),
  );

  pw.Table totalprice() {
    return pw.Table(
      columnWidths: <int, pw.TableColumnWidth>{
        0: pw.FixedColumnWidth(120),
        1: pw.FixedColumnWidth(40),
        2: pw.FixedColumnWidth(60),
        3: pw.FixedColumnWidth(50),
        4: pw.FixedColumnWidth(70),
      },
      children: <pw.TableRow>[
        pw.TableRow(
          // decoration: pw.BoxDecoration(
          //   color: convertColor(templateController.tableHeaderColor.value),
          // ),
          children: <pw.Widget>[
            pw.Padding(
              padding: pw.EdgeInsets.all(10.0),
              child: pw.Text(
                "",
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: 8,
                  color: PdfColors.white,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.all(10.0),
              child: pw.Text(
                "",
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: 8,
                  color: PdfColors.white,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.all(10.0),
              child: pw.Text(
                "",
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: 8,
                  color: PdfColors.white,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.all(10.0),
              child: pw.Text(
                "",
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: 8,
                  color: PdfColors.white,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.all(10.0),
              child: pw.Text(
                "TOTAL : ",
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: 15,
                  color: PdfColors.black,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.all(10.0),
              child: pw.Text(
                itemListController.totalPrice.toString(),
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: 15,
                  color: PdfColors.black,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  pw.Table table() {
    // final NewItemsController itemsController = NewItemsController();

    final ItemListController itemListController = Get.put(
      ItemListController(),
    );

    List<pw.TableRow> rows = [];

    for (var product in itemListController.itemlist) {
      rows.add(
        pw.TableRow(
          decoration: pw.BoxDecoration(
              // border: pw.Border(
              //   bottom: pw.BorderSide(
              //       color: PdfColors.white, width: 0), // <<< No visible border
              // ),
              ),
          children: <pw.Widget>[
            pw.Padding(
              padding: pw.EdgeInsets.all(10.0),
              child: pw.Text(
                product["name"],
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.all(10.0),
              child: pw.Text(
                product["quantity"],
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.all(10.0),
              child: pw.Text(
                product["unitofmeasure"],
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.all(10.0),
              child: pw.Text(
                product["unitprice"],
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.all(10.0),
              child: pw.Text(
                // "${double.parse(product["quantity"]) * double.parse(product["unitprice"])}",
                product["total"],
                textAlign: pw.TextAlign.end,
                style: pw.TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return pw.Table(
      // border: null,
      border: pw.TableBorder.all(color: PdfColors.grey.shade(0.10)),
      columnWidths: const <int, pw.TableColumnWidth>{
        0: pw.FixedColumnWidth(120),
        1: pw.FixedColumnWidth(40),
        2: pw.FixedColumnWidth(60),
        3: pw.FixedColumnWidth(50),
        4: pw.FixedColumnWidth(70),
      },
      children: <pw.TableRow>[
        pw.TableRow(
          decoration: pw.BoxDecoration(
            color: PdfColors.white,
            // border: pw.Border.all(
            //   style: pw.BorderStyle.solid,
            //   color: PdfColors.black,
            //   width: 2,
            // ),
          ),
          children: <pw.Widget>[
            pw.Padding(
              padding: pw.EdgeInsets.all(10.0),
              child: pw.Text(
                "Name",
                textAlign: pw.TextAlign.start,
                style: pw.TextStyle(
                  fontSize: 15,
                  color: PdfColors.black,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.all(10.0),
              child: pw.Text(
                "Qty",
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: 15,
                  color: PdfColors.black,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.all(10.0),
              child: pw.Text(
                "Unit",
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: 15,
                  color: PdfColors.black,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.all(10.0),
              child: pw.Text(
                "Price",
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: 15,
                  color: PdfColors.black,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.all(10.0),
              child: pw.Text(
                "Amount",
                textAlign: pw.TextAlign.end,
                style: pw.TextStyle(
                  fontSize: 15,
                  color: PdfColors.black,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        ...rows,
      ],
    );
  }

  Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    final output = await getTemporaryDirectory();
    var filePath = "${output.path}/$fileName.pdf";
    final file = File(filePath);
    await file.writeAsBytes(byteList);
    await OpenFile.open(filePath);
  }
}
