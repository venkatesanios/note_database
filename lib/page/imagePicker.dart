import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Myimage extends StatefulWidget {
  @override
  _MyimageState createState() => _MyimageState();
}

class _MyimageState extends State<Myimage> {
  /// Variables
  XFile? imageFile;
  ImagePicker picker = ImagePicker();
  XFile? image;

  /// Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Image Picker"),
        ),
        body: Container(
            child: imageFile == null
                ? Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          //color: Colors.greenAccent,
                          onPressed: () {
                            _getFromGallery();
                          },
                          child: Text("PICK FROM GALLERY"),
                        ),
                        Container(
                          height: 40.0,
                        ),
                        ElevatedButton(
                          // color: Colors.lightGreenAccent,
                          onPressed: () {
                            _getFromCamera();
                          },
                          child: Text("PICK FROM CAMERA"),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              image = await picker.pickImage(
                                  source: ImageSource.camera);
                              setState(() {
                                //update UI
                              });
                            },
                            child: Text("Pick Image")),
                        image == null
                            ? Container()
                            : Image.file(File(image!.path)),
                      ],
                    ),
                  )
                // : Container(
                //     child: Image.file(
                //       imageFile,
                //       fit: BoxFit.cover,
                //     ),
                //   )
                : Container(
                    height: 10,
                  )));
  }

  /// Get from gallery
  _getFromGallery() async {
    PickedFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1000,
      maxWidth: 1000,
    ) as PickedFile?;

    if (pickedFile != null) {
      setState(() {
        imageFile = "File(pickedFile.path)" as XFile?;

        imageFile = File(pickedFile.path) as XFile?;
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = pickedFile.path as XFile?;
        //    File(pickedFile.path);
      });
    }
  }
}
