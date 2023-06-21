import 'package:flutter/material.dart';
import 'package:note_database/Scaner/qrcoded/barcode_list_scanner_controller.dart';
import 'package:note_database/Scaner/qrcoded/barcode_scanner_controller.dart';
import 'package:note_database/Scaner/qrcoded/barcode_scanner_pageview.dart';
import 'package:note_database/Scaner/qrcoded/barcode_scanner_returning_image.dart';
import 'package:note_database/Scaner/qrcoded/barcode_scanner_window.dart';
import 'package:note_database/Scaner/qrcoded/barcode_scanner_without_controller.dart';
import 'package:note_database/Scaner/qrcoded/barcode_scanner_zoom.dart';

class MyHomeQRcode extends StatelessWidget {
  const MyHomeQRcode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Demo Home Page')),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        const BarcodeListScannerWithController(),
                  ),
                );
              },
              child: const Text('MobileScanner with List Controller'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const BarcodeScannerWithController(),
                  ),
                );
              },
              child: const Text('MobileScanner with Controller'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const BarcodeScannerWithScanWindow(),
                  ),
                );
              },
              child: const Text('MobileScanner with ScanWindow'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const BarcodeScannerReturningImage(),
                  ),
                );
              },
              child:
                  const Text('MobileScanner with Controller (returning image)'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        const BarcodeScannerWithoutController(),
                  ),
                );
              },
              child: const Text('MobileScanner without Controller'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const BarcodeScannerWithZoom(),
                  ),
                );
              },
              child: const Text('MobileScanner with zoom slider'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const BarcodeScannerPageView(),
                  ),
                );
              },
              child: const Text('MobileScanner pageView'),
            ),
          ],
        ),
      ),
    );
  }
}
