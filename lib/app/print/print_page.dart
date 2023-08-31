// ignore_for_file: public_member_api_docs

import 'dart:typed_data';

import 'package:egu_industry/app/common/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';



class PrintPage extends StatelessWidget {
  const PrintPage(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            leading: TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
              ),
              onPressed: () {
                Get.back();
              },
              child: SvgPicture.asset('assets/app/arrow2Left.svg', color: AppTheme.black,),
            ),
            title: Text('프린트', style: AppTheme.a18700.copyWith(color: Colors.black),)
        ),
        body: PdfPreview(
          build: (format) => _generatePdf(format, title),
        ),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final doc = pw.Document();
    final image = await imageFromAssetBundle('assets/app/pngImage.png');
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text('label test'),
              pw.SizedBox(height: 50),
              pw.Image(image)
            ],
          ); // Center
        })); // Page

    return doc.save();
  }
}