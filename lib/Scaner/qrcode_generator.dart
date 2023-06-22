import 'package:flutter/material.dart';
import 'package:note_database/Scaner/image_builder.dart';
import 'package:note_database/Scaner/save_btn.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQRCode extends StatefulWidget {
  const GenerateQRCode({Key? key}) : super(key: key);

  @override
  GenerateQRCodeState createState() => GenerateQRCodeState();
}

class GenerateQRCodeState extends State<GenerateQRCode> {
  TextEditingController controller = TextEditingController();
  String qrData = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR code Generator'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your URL',
              ),
              maxLines: 5,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                qrData = controller.text;
              });
            },
            child: const Text('GENERATE QR CODE'),
          ),
          if (qrData.isNotEmpty)
            QrImageView(
              data: qrData,
              version: QrVersions.auto,
              size: 200.0,
            ),
          const Align(
            alignment: Alignment.topRight,
            child: ImageBuilder(
              imagePath: "assets/images/image.png",
              imgWidth: 250,
              imgheight: 250,
            ),
          ),
          // ElevatedButton(D:\venkatesan\sql\note_database\
          //   onPressed: () {
          //     setState(() {
          //       qrData = controller.text;
          //     });
          //   },
          //   child: const Text('Print '),
          // ),
          SaveBtnBuilder(),
        ],
      ),
    );
  }
}
