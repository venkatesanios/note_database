// main.dart
import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

// This widget is reusable
class MultiSelection extends StatefulWidget {
  final List<String> items;
  const MultiSelection({Key? key, required this.items}) : super(key: key);
  @override
  State<MultiSelection> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelection> {
  // this variable holds the selected items
  final List<String> _selectedItems = [];

  /// This function is triggered when a checkbox is checked or unchecked
  /// this function get two paramerers string itemvalue of array elements and isselected value
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      isSelected
          ? _selectedItems.add(itemValue)
          : _selectedItems.remove(itemValue);
    });
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    // Navigator.pop(context, _selectedItems);
    alertanimation(context, _selectedItems);
  }

  alertanimation(BuildContext context, List prglist) {
    print(prglist);
    String prg = '';
    prg = prglist.join('\n');

    AwesomeDialog dialog = AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.scale,
      title: 'we are selected Programs are',
      desc: prg,
      autoDismiss: true,
      headerAnimationLoop: true,
    );
    dialog.show();

    Timer(const Duration(seconds: 5), () {
      setState(() {
        dialog.dismiss();
        Navigator.pop(context, _selectedItems);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Program'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => CheckboxListTile(
                    value: _selectedItems.contains(item),
                    title: Text(item),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isChecked) => _itemChange(item, isChecked!),
                  ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _cancel,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
