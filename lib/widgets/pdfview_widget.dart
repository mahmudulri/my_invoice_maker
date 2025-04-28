// import 'package:flutter/material.dart';
// import 'dart:typed_data';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import '../services/ems_pdf_service.dart'; // adjust the path as needed

// class PdfViewerWidget extends StatefulWidget {
//   const PdfViewerWidget({super.key});

//   @override
//   State<PdfViewerWidget> createState() => _PdfViewerWidgetState();
// }

// class _PdfViewerWidgetState extends State<PdfViewerWidget> {
//   Uint8List? _pdfBytes;
//   final EmsPdfService _emsPdfService = EmsPdfService();

//   @override
//   void initState() {
//     super.initState();
//     loadPdf();
//   }

//   Future<void> loadPdf() async {
//     final pdfData = await _emsPdfService.generatePDF();
//     setState(() {
//       _pdfBytes = pdfData;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _pdfBytes == null
//         ? const Center(child: CircularProgressIndicator())
//         : SfPdfViewer.memory(_pdfBytes!);
//   }
// }
