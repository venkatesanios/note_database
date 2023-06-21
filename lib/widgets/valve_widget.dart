import 'package:flutter/material.dart';
import 'package:note_database/model/valvemodel.dart';

class ValveListWidget extends StatefulWidget {
  const ValveListWidget({
    Key? key,
    required this.valve,
    required this.index,
  }) : super(key: key);

  final List<Valve> valve;
  final int index;

  @override
  State<ValveListWidget> createState() => _ValveListWidgetState();
}

class _ValveListWidgetState extends State<ValveListWidget> {
  @override
  Widget build(BuildContext context) {
    /// Pick colors from the accent colors based on index
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
                  widget.valve[widget.index].valvename,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              widget.valve[widget.index].time,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Spacer(),
            Text(
              widget.valve[widget.index].flow,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Text(
              widget.valve[widget.index].pressure,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Text(
              widget.valve[widget.index].cycrst,
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
}
