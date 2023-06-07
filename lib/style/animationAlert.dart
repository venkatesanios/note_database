import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class alertanimate extends StatelessWidget {
  const alertanimate({super.key, required this.title, required this.message});
  final String title;
  final String message;

  alet(context) {
    AwesomeDialog dialog = AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      title: title,
      desc: message,
      autoDismiss: true,
      headerAnimationLoop: true,
      //transitionAnimationDuration: Duration(seconds: 3),
    );
    dialog.show();

    Timer(const Duration(seconds: 5), () {
      //setState(() {
      dialog.dismiss();
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    alet(context);
    return alet(context);
  }
}
