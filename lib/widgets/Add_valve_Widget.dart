import 'package:flutter/material.dart';

class ValveFormWidget extends StatelessWidget {
  final int? id;
  final int? programid;
  final String? programname;
  final String? valvename;
  final String? time;
  final String? flow;
  final String? pressure;
  final String? cycrst;

  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedSetting1;
  final ValueChanged<String> onChangedSetting2;
  final ValueChanged<String> onChangedSetting3;
  final ValueChanged<String> onChangedDescription;

  const ValveFormWidget({
    Key? key,
    this.id = 0,
    this.programid = 0,
    this.programname = '',
    this.valvename = '',
    this.time = '',
    this.flow = '',
    this.pressure = '',
    this.cycrst = '',
    required this.onChangedNumber,
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onChangedSetting1,
    required this.onChangedSetting2,
    required this.onChangedSetting3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildValvename(),
              const SizedBox(height: 8),
              buildTime(),
              const SizedBox(height: 8),
              buildFlow(),
              const SizedBox(height: 8),
              buildPressure(),
              const SizedBox(height: 8),
              buildCycRst(),
              const SizedBox(height: 8),
            ],
          ),
        ),
      );

  Widget buildValvename() => TextFormField(
        maxLines: 1,
        initialValue: valvename,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Valve name:',
          hintStyle: TextStyle(color: Colors.white60),
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'The title cannot be empty' : null,
        onChanged: onChangedTitle,
      );

  Widget buildTime() => TextFormField(
        maxLines: 1,
        initialValue: time,
        style: const TextStyle(color: Colors.white60, fontSize: 18),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Time: ',
          hintStyle: TextStyle(color: Colors.white60),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The zone name cannot be empty'
            : null,
        onChanged: onChangedDescription,
      );

  Widget buildFlow() => TextFormField(
        maxLines: 1,
        initialValue: flow,
        style: const TextStyle(color: Colors.white60, fontSize: 18),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Flow: ',
          hintStyle: TextStyle(color: Colors.white60),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The Settings cannot be empty'
            : null,
        onChanged: onChangedSetting1,
      );

  Widget buildPressure() => TextFormField(
        maxLines: 1,
        initialValue: pressure,
        style: const TextStyle(color: Colors.white60, fontSize: 18),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Pressure:  ',
          hintStyle: TextStyle(color: Colors.white60),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The Settings cannot be empty'
            : null,
        onChanged: onChangedSetting2,
      );

  Widget buildCycRst() => TextFormField(
        maxLines: 1,
        initialValue: cycrst,
        style: const TextStyle(color: Colors.white60, fontSize: 18),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Cyclic Restart:',
          hintStyle: TextStyle(color: Colors.white60),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The Settings cannot be empty'
            : null,
        onChanged: onChangedSetting3,
      );
}
