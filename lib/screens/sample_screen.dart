import 'package:flutter/material.dart';

import '../pdftemplates/pdftemplate1.dart';
import 'pdf_template_screen.dart';

class SampleScreen extends StatelessWidget {
  SampleScreen({super.key});

  final List<String> pdfAssets = [
    'assets/pdf/sample1.pdf',
    'assets/pdf/sample1.pdf',
    'assets/pdf/sample1.pdf',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF Sample"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.7,
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemCount: pdfAssets.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2), // shadow color
                    spreadRadius: 2, // spread radius
                    blurRadius: 2, // blur radius
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
                color: Colors.white,
              ),
              child: Container(),
            );
          },
        ),
      ),
    );
  }
}
