import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_database/model/note.dart';
import 'package:note_database/page/checklist_boxArray.dart';

class ProgramListWidget extends StatefulWidget {
  const ProgramListWidget({
    Key? key,
    required this.notes,
    required this.index,
  }) : super(key: key);

  final List<Note> notes;
  final int index;

  @override
  State<ProgramListWidget> createState() => _ProgramListWidgetState();
}

class _ProgramListWidgetState extends State<ProgramListWidget> {
  List<String> _Selecteditem = [];

  void _showMultiSelect() async {
    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelection(
            items: widget.notes
                .where((element) => element.id != widget.notes[widget.index].id)
                .map((e) => e.title)
                .toList());
      },
    );
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
    final date =
        DateFormat.yMMMd().format(widget.notes[widget.index].createdTime);
    final times =
        DateFormat.Hms().format(widget.notes[widget.index].createdTime);
    final time = "$date-$times";

    return Card(
      color: Colors.lightGreen.shade300,
      child: Container(
        constraints: const BoxConstraints(minHeight: 100),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.notes[widget.index].title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  child: IconButton(
                    onPressed: _showMultiSelect,
                    icon: const Icon(Icons.info),
                  ),
                ),
              ],
            ),
            Text(
              widget.notes[widget.index].description,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Last updated : $time',
              style: TextStyle(color: Colors.grey.shade900, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
