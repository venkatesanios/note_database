import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_database/model/programmodel.dart';
import 'package:note_database/page/checklist_boxArray.dart';

class ProgramListWidget extends StatefulWidget {
  const ProgramListWidget({
    Key? key,
    required this.programs,
    required this.index,
  }) : super(key: key);

  final List<Program> programs;
  final int index;

  @override
  State<ProgramListWidget> createState() => _ProgramListWidgetState();
}

class _ProgramListWidgetState extends State<ProgramListWidget> {
  List<Program> _Selecteditem = [];

  void _showMultiSelect() async {
    final List<Program>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        final clickedProgram = widget.programs[widget.index];
        return MultiSelection(
          items: widget.programs
              .where(
                  (element) => element.id != widget.programs[widget.index].id)
              .map((e) => e)
              .toList(),
          clickedProgram: clickedProgram,
        );
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
        DateFormat.yMMMd().format(widget.programs[widget.index].createdTime);
    final times =
        DateFormat.Hms().format(widget.programs[widget.index].createdTime);
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
                  widget.programs[widget.index].title,
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
              widget.programs[widget.index].description,
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
