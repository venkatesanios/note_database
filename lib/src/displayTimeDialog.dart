import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<void> displayTimeDialog(
    BuildContext context, TextEditingController controller) async {
  final TimeOfDay? time = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    initialEntryMode: TimePickerEntryMode.input,
    builder: (BuildContext context, Widget? child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      );
    },
  );

  if (time != null) {
    final formattedTime = DateFormat.Hm().format(DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      time.hour,
      time.minute,
    ));
    controller.text = formattedTime;
  }
}
