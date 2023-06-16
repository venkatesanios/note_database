import 'dart:ffi';

import 'package:flutter/material.dart';

class Permission {
  Future<Void> CheckPermission(
      Permission permission, BuildContext context) async {
    final status = await permission.request();

    if (status.isGranted) {
      print('Permission Granted storage');
    } else {
      if (await permission.request().isGranted) {
        print('Permission was granted storage');
      }
    }
  }
}
