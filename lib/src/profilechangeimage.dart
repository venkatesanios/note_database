import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

XFile? Profileimage(BuildContext context) {
  XFile? image;
  ImagePicker picker = ImagePicker();
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Select any option',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            ElevatedButton(
              onPressed: () async {
                image = await picker.pickImage(source: ImageSource.camera);
                // setState(() {
                //   //update UI
                // });
              },
              child: const Text('Open Camera'),
            ),
            TextButton(
              child: const Text('    '),
              onPressed: () {},
            ),
            ElevatedButton(
              onPressed: () async {
                image = await picker.pickImage(source: ImageSource.gallery);
                // setState(() {});
              },
              child: const Text('Open Gallery'),
            ),
          ],
        );
      });
  return image;
}
