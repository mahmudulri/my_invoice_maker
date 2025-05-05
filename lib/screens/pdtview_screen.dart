import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:printing/printing.dart'; // <--- Add this
import 'dart:io';
import 'package:share_plus/share_plus.dart'; // <--- Add this
import '../pdftemplates/pdftemplate1.dart';
import '../pdftemplates/pdftemplate2.dart';
import 'package:permission_handler/permission_handler.dart';

import '../pdftemplates/pdftemplate3.dart';
import '../pdftemplates/pdftemplate4.dart';
import '../pdftemplates/pdftemplate5.dart';
import '../pdftemplates/pdftemplate6.dart';

class PdfPreviewScreen extends StatefulWidget {
  final Uint8List pdfBytes;

  const PdfPreviewScreen({Key? key, required this.pdfBytes}) : super(key: key);

  @override
  State<PdfPreviewScreen> createState() => _PdfPreviewScreenState();
}

class _PdfPreviewScreenState extends State<PdfPreviewScreen> {
  late Uint8List _currentPdfBytes;

  final PdfTemplate1 pdfTemplate1 = PdfTemplate1();
  final PdfTemplate2 pdfTemplate2 = PdfTemplate2();
  final PdfTemplate3 pdfTemplate3 = PdfTemplate3();
  final PdfTemplate4 pdfTemplate4 = PdfTemplate4();
  final PdfTemplate5 pdfTemplate5 = PdfTemplate5();
  final PdfTemplate6 pdfTemplate6 = PdfTemplate6();

  @override
  void initState() {
    super.initState();
    _currentPdfBytes = widget.pdfBytes;
  }

  void _loadNewPdf(Uint8List newPdfBytes) {
    setState(() {
      _currentPdfBytes = newPdfBytes;
    });
  }

  Future<void> _printPdf() async {
    await Printing.layoutPdf(onLayout: (_) => _currentPdfBytes);
  }

  // Future<void> _savePdf() async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final filePath = '${directory.path}/saved_invoice.pdf';
  //   final file = File(filePath);
  //   await file.writeAsBytes(_currentPdfBytes);
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text('PDF saved at ${file.path}')),
  //   );
  // }
  Future<bool> _requestPermission() async {
    if (Platform.isAndroid) {
      var status = await Permission.manageExternalStorage.request();
      return status.isGranted;
    } else {
      return true;
    }
  }

  Future<void> _savePdf() async {
    try {
      _requestPermission();

      bool permissionGranted = await _requestPermission();
      if (!permissionGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Storage permission denied')),
        );
        return; // stop saving
      }

      // Get Documents folder
      final directory = Directory('/storage/emulated/0/Documents');

      if (!await directory.exists()) {
        await directory.create(recursive: true); // create if not exists
      }

      // Save PDF into Documents
      final filePath =
          '${directory.path}/saved_invoice_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final file = File(filePath);
      await file.writeAsBytes(_currentPdfBytes);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('✅ PDF saved in Documents: $filePath')),
      );
    } catch (e) {
      print('Error saving PDF: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving PDF: $e')),
      );
    }
  }

  Future<void> _sharePdf() async {
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/shared_invoice.pdf';
    final file = File(filePath);
    await file.writeAsBytes(_currentPdfBytes);
    // ignore: deprecated_member_use
    await Share.shareXFiles([XFile(filePath)],
        text: 'Here is your invoice PDF!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffbdc3c7),
      appBar: AppBar(title: Text("Invoice Preview")),
      body: Column(
        children: [
          Container(
            height: 550,
            margin: EdgeInsets.all(10),
            width: double.infinity,
            child: SfPdfViewerTheme(
              data: SfPdfViewerThemeData(
                backgroundColor: Colors.transparent,
              ),
              child: SfPdfViewer.memory(
                _currentPdfBytes,
                canShowScrollHead: true,
                canShowScrollStatus: true,
              ),
            ),
          ),
          Container(
            height: 40,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final data = await pdfTemplate1.generatePDF();
                      _loadNewPdf(data);
                    },
                    child: Text(" 1"),
                  ),
                  SizedBox(width: 5),
                  ElevatedButton(
                    onPressed: () async {
                      final data = await pdfTemplate2.generatePDF();
                      _loadNewPdf(data);
                    },
                    child: Text(" 2"),
                  ),
                  SizedBox(width: 5),
                  ElevatedButton(
                    onPressed: () async {
                      final data = await pdfTemplate3.generatePDF();
                      _loadNewPdf(data);
                    },
                    child: Text(" 3"),
                  ),
                  SizedBox(width: 5),
                  ElevatedButton(
                    onPressed: () async {
                      final data = await pdfTemplate4.generatePDF();
                      _loadNewPdf(data);
                    },
                    child: Text(" 4"),
                  ),
                  SizedBox(width: 5),
                  ElevatedButton(
                    onPressed: () async {
                      final data = await pdfTemplate5.generatePDF();
                      _loadNewPdf(data);
                    },
                    child: Text(" 5"),
                  ),
                  SizedBox(width: 5),
                  ElevatedButton(
                    onPressed: () async {
                      final data = await pdfTemplate6.generatePDF();
                      _loadNewPdf(data);
                    },
                    child: Text(" 6"),
                  ),
                ],
              ),
            ),
          ),
          // space between rows
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: _printPdf,
                label: Text("Print"),
              ),
              SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: _savePdf,
                label: Text("Save"),
              ),
              SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: _sharePdf,
                label: Text("Share"),
              ),
              SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }
}
