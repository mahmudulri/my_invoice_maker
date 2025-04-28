import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:invoice_maker/dashboard.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:printing/printing.dart'; // <--- Add this
import 'package:path_provider/path_provider.dart'; // <--- Add this
import 'dart:io';
import 'package:share_plus/share_plus.dart'; // <--- Add this

import '../pdftemplates/pdftemplate1.dart';
import '../pdftemplates/pdftemplate2.dart';

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

  Future<void> _savePdf() async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/saved_invoice.pdf';
    final file = File(filePath);
    await file.writeAsBytes(_currentPdfBytes);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('PDF saved at ${file.path}')),
    );
  }

  Future<void> _sharePdf() async {
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/shared_invoice.pdf';
    final file = File(filePath);
    await file.writeAsBytes(_currentPdfBytes);
    await Share.shareXFiles([XFile(filePath)],
        text: 'Here is your invoice PDF!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(title: Text("Invoice Preview")),
      body: Column(
        children: [
          Container(
            height: 550,
            color: Colors.red,
            margin: EdgeInsets.all(10),
            width: double.infinity,
            child: SfPdfViewerTheme(
              data: SfPdfViewerThemeData(
                backgroundColor: Colors.grey,
              ),
              child: SfPdfViewer.memory(
                _currentPdfBytes,
                canShowScrollHead: true,
                canShowScrollStatus: true,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final data = await pdfTemplate1.generatePDF();
                  _loadNewPdf(data);
                },
                child: Text("PDF 1"),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () async {
                  final data = await pdfTemplate2.generatePDF();
                  _loadNewPdf(data);
                },
                child: Text("PDF 2"),
              ),
            ],
          ),
          SizedBox(height: 20), // space between rows
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: _printPdf,
                icon: Icon(Icons.print),
                label: Text("Print"),
              ),
              SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: _savePdf,
                icon: Icon(Icons.save),
                label: Text("Save"),
              ),
              SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: _sharePdf,
                icon: Icon(Icons.share),
                label: Text("Share"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
