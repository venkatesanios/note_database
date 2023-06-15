// main.dart
import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class MultiSelection extends StatefulWidget {
  final List<String> items;
  const MultiSelection({Key? key, required this.items}) : super(key: key);
  @override
  State<MultiSelection> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelection> {
  final List<String> _selectedItems = [];
  bool _selectAllFlag = false;

  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      isSelected
          ? _selectedItems.add(itemValue)
          : _selectedItems.remove(itemValue);
    });
  }

  void _cancel() {
    Navigator.pop(context);
  }

  void _submit() {
    alertanimation(context, _selectedItems);
  }

  void _toggleSelectAll() {
    setState(() {
      if (_selectedItems.length == widget.items.length) {
        _selectedItems.clear();
      } else {
        _selectedItems.clear();
        _selectedItems.addAll(widget.items);
      }
    });
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
    bool selectAll = _selectedItems.length == widget.items.length;

    return AlertDialog(
      title: const Text('Create Duplicate Program'),
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
          onPressed: _toggleSelectAll,
          // child: Text(_selectAllFlag ? 'Clear All' : 'Select All'),
          child: Text(selectAll ? 'Clear All' : 'Select All'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
