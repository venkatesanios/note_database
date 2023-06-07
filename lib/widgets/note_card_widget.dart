import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_database/model/note.dart';
import 'package:note_database/page/checklist_boxArray.dart';

final _lightColors = [
  Colors.amber.shade300,
  Colors.lightGreen.shade300,
  Colors.lightBlue.shade300,
  Colors.orange.shade300,
  Colors.pinkAccent.shade100,
  Colors.tealAccent.shade100
];

class NoteCardWidget extends StatefulWidget {
  const NoteCardWidget({
    Key? key,
    required this.note,
    required this.index,
  }) : super(key: key);

  final Note note;
  final int index;

  @override
  State<NoteCardWidget> createState() => _NoteCardWidgetState();
}

class _NoteCardWidgetState extends State<NoteCardWidget> {
  List<String> _Selecteditem = [];

  void _showMultiSelect() async {
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API
    final List<String> items = [
      'Program 1',
      'Program 2',
      'Program 3',
      'Program 4',
      'Program 5',
      'Program 6'
    ];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelection(items: items);
      },
    );

    print('results: $results');

    // Update UI
    if (results != null) {
      setState(() {
        _Selecteditem = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Pick colors from the accent colors based on index
    final color = _lightColors[widget.index % _lightColors.length];
    final date = DateFormat.yMMMd().format(widget.note.createdTime);
    final times = DateFormat.Hms().format(widget.note.createdTime);
    final time = "$date-$times";
    final minHeight = getMinHeight(widget.index);

    return Card(
      color: color,
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  time,
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 11),
                ),
                Container(
                  child: IconButton(
                    onPressed: _showMultiSelect,
                    icon: const Icon(Icons.info),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              widget.note.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              widget.note.description,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// To return different height for different widgets
  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 200;
      case 3:
        return 120;
      default:
        return 170;
    }
  }
}
