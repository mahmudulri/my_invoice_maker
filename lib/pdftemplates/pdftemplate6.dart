import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:invoice_maker/invoicecontrollers/new_items_controller.dart';
import 'package:invoice_maker/invoicecontrollers/template_theme_controller.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// TemplateController templateController = Get.put(
//   TemplateController(),
// );

class PdfTemplate6 {
  Future<Uint8List> generatePDF() async {
    final pdf = pw.Document();
    List<pw.Widget> widgets = [];
    final logo =
        (await rootBundle.load("assets/icons/logo.png")).buffer.asUint8List();

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
      color: PdfColor.fromHex('2ecc71'),
    );
    final addressArea = pw.Container(
      height: 100,
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
                  "Lihan Enterprise",
                  style: pw.TextStyle(
                    fontSize: 15,
                  ),
                ),
                pw.Text(
                  "Radhanagor Bazar, Sreepur",
                  style: pw.TextStyle(
                    fontSize: 15,
                  ),
                ),
                pw.Text(
                  "Magura",
                  style: pw.TextStyle(
                    fontSize: 15,
                  ),
                ),
                pw.Text(
                  "01816000000",
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
                  "Goodlife Pharmacy",
                  style: pw.TextStyle(
                    fontSize: 15,
                  ),
                ),
                pw.Text(
                  "Nakol Bazar, Sreepur",
                  style: pw.TextStyle(
                    fontSize: 15,
                  ),
                ),
                pw.Text(
                  "Magura",
                  style: pw.TextStyle(
                    fontSize: 15,
                  ),
                ),
                pw.Text(
                  "01816000000",
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
      height: 80,
      color: PdfColors.grey.shade(0.20),
      child: pw.Row(
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text("Total"),
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
    final gap80 = pw.SizedBox(height: 80);
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
    widgets.add(gap80);
    widgets.add(totalprice());

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
                "1254.20",
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
    final NewItemsController itemsController = NewItemsController();
    List<pw.TableRow> rows = [];

    for (var product in itemsController.products) {
      rows.add(
        pw.TableRow(
          decoration: pw.BoxDecoration(
              // border: pw.Border(
              //   bottom: pw.BorderSide(
              //     color: PdfColors.black,
              //     width: 1,
              //   ), // <<< No visible border
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
                product["quantitytype"],
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.all(10.0),
              child: pw.Text(
                "${double.parse(product["quantity"]) * double.parse(product["unitprice"])}",
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
          decoration: pw.BoxDecoration(color: PdfColor.fromHex('2ecc71')
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
                  color: PdfColors.white,
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
                  color: PdfColors.white,
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
                  color: PdfColors.white,
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
                  color: PdfColors.white,
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
                  color: PdfColors.white,
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
