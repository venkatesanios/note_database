import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {
  final bool? isImportant;
  final int? number;
  final String? title;
  final String? description;
  final String? settings1;
  final String? settings2;
  final String? settings3;

  final ValueChanged<bool> onChangedImportant;
  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedSetting1;
  final ValueChanged<String> onChangedSetting2;
  final ValueChanged<String> onChangedSetting3;
  final ValueChanged<String> onChangedDescription;

  const NoteFormWidget({
    Key? key,
    this.isImportant = false,
    this.number = 0,
    this.title = '',
    this.description = '',
    this.settings1 = '',
    this.settings2 = '',
    this.settings3 = '',
    required this.onChangedImportant,
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
              Row(
                children: [
                  Switch(
                    inactiveThumbColor: Colors.red,
                    activeColor: Colors.green,
                    value: isImportant ?? false,
                    onChanged: onChangedImportant,
                  ),
                  Expanded(
                    child: Slider(
                      value: (number ?? 0).toDouble(),
                      min: 0,
                      max: 5,
                      divisions: 5,
                      onChanged: (number) => onChangedNumber(number.toInt()),
                    ),
                  )
                ],
              ),
              buildTitle(),
              const SizedBox(height: 8),
              buildDescription(),
              const SizedBox(height: 8),
              buildSettings1(),
              const SizedBox(height: 8),
              buildSettings2(),
              const SizedBox(height: 8),
              buildSettings3(),
              const SizedBox(height: 8),
            ],
          ),
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Program name',
          hintStyle: TextStyle(color: Colors.white60),
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'The title cannot be empty' : null,
        onChanged: onChangedTitle,
      );

  Widget buildDescription() => TextFormField(
        maxLines: 1,
        initialValue: description,
        style: const TextStyle(color: Colors.white60, fontSize: 18),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Zone Name ',
          hintStyle: TextStyle(color: Colors.white60),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The zone name cannot be empty'
            : null,
        onChanged: onChangedDescription,
      );

  Widget buildSettings1() => TextFormField(
        maxLines: 1,
        initialValue: settings1,
        style: const TextStyle(color: Colors.white60, fontSize: 18),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Settings1: ',
          hintStyle: TextStyle(color: Colors.white60),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The Settings cannot be empty'
            : null,
        onChanged: onChangedSetting1,
      );

  Widget buildSettings2() => TextFormField(
        maxLines: 1,
        initialValue: settings2,
        style: const TextStyle(color: Colors.white60, fontSize: 18),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Settings2:  ',
          hintStyle: TextStyle(color: Colors.white60),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The Settings cannot be empty'
            : null,
        onChanged: onChangedSetting2,
      );

  Widget buildSettings3() => TextFormField(
        maxLines: 1,
        initialValue: settings3,
        style: const TextStyle(color: Colors.white60, fontSize: 18),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Settings3:',
          hintStyle: TextStyle(color: Colors.white60),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The Settings cannot be empty'
            : null,
        onChanged: onChangedSetting3,
      );
}
