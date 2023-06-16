// main.dart
import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:note_database/model/note.dart';

import '../db/program_database.dart';

// This widget is reusable
class MultiSelection extends StatefulWidget {
  final List<Program> items;
  final Program clickedProgram;

  const MultiSelection({Key? key, required this.items, required this.clickedProgram}) : super(key: key);
  @override
  State<MultiSelection> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelection> {
  // this variable holds the selected items
  final List<Program> _selectedItems = [];

  /// This function is triggered when a checkbox is checked or unchecked
  /// this function get two paramerers string itemvalue of array elements and isselected value
  void _itemChange(Program itemValue, bool isSelected) {
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
    if (widget.clickedProgram != null) {
    // Navigator.pop(context, _selectedItems);
   List selectitem = [];
    _selectedItems.forEach((element) async{
Program note;
note = element.copy(
  setting1: widget.clickedProgram!.setting1,
  setting2: widget.clickedProgram!.setting2,
  setting3: widget.clickedProgram!.setting3,
  isImportant: widget.clickedProgram!.isImportant,
  number: widget.clickedProgram!.number,
  description: widget.clickedProgram!.description
);
selectitem.add(element.title);
 await ProgramDatabase.instance.update(note);

 alertanimation(context, selectitem);
     });
     
  }
  else{
    alertanimation(context, ['No item Select']);
  }
}

  alertanimation(BuildContext context, List prglist) {
        print('alertanimation');
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
      title: const Text('Create Duplicate Program'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => CheckboxListTile(
                    value: _selectedItems.contains(item),
                    title: Text(item.title),
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
