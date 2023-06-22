import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

buildPrintableData(image) => pw.Padding(
      padding: const pw.EdgeInsets.all(25.00),
      child: pw.Column(children: [
        pw.Text("ORO",
            style:
                pw.TextStyle(fontSize: 25.00, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 10.00),
        // pw.Divider(),
        pw.Align(
          alignment: pw.Alignment.topRight,
          child: pw.Image(
            image,
            width: 250,
            height: 250,
          ),
        ),
        pw.Column(
          children: [
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.SizedBox(width: 5.5),
                pw.Center(
                  child: pw.Text(
                    "2345678909876543",
                    style: pw.TextStyle(
                        color: const PdfColor(0.0, 0.0, 0.0, 0.7),
                        fontSize: 20.00,
                        fontWeight: pw.FontWeight.bold),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        )
      ]),
    );
