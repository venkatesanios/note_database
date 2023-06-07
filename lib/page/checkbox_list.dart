import 'package:flutter/material.dart';

class MyCheckboxList extends StatefulWidget {
  const MyCheckboxList({super.key});

  @override
  _MyCheckboxListState createState() => _MyCheckboxListState();
}

class _MyCheckboxListState extends State<MyCheckboxList> {
  List<String> itemList = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    // Add more items as needed
  ];

  List<bool> checkedList = List.filled(4, false); // Initialize with false values

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Wrap with Scaffold
        appBar: AppBar(
          title: const Text('Checkbox List'),
        ),
        body: ListView.builder(
          itemCount: itemList.length,
          itemBuilder: (context, index) {
            return CheckboxListTile(
              title: Text(itemList[index],style: const TextStyle(color: Colors.white),),
              value: checkedList[index],
              onChanged: (bool? value) {
                setState(() {
                  checkedList[index] = value ?? false;
                });
              },
            );
          },
        ),

    );
  }
}

void main() {
  runApp(const MyCheckboxList());
}
