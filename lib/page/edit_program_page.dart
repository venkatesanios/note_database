import 'package:flutter/material.dart';
import 'package:note_database/widgets/program_Add_widget.dart';

import '../db/program_database.dart';
import '../model/programmodel.dart';

class AddEditProgramPage extends StatefulWidget {
  final Program? program;

  const AddEditProgramPage({
    Key? key,
    this.program,
  }) : super(key: key);
  @override
  _AddEditProgramPageState createState() => _AddEditProgramPageState();
}

class _AddEditProgramPageState extends State<AddEditProgramPage> {
  final _formKey = GlobalKey<FormState>();
  late bool isImportant;
  late int number;
  late String title;
  late String description;
  late String setting1;
  late String setting2;
  late String setting3;

  @override
  void initState() {
    super.initState();

    isImportant = widget.program?.isImportant ?? false;
    number = widget.program?.number ?? 0;
    title = widget.program?.title ?? '';
    description = widget.program?.description ?? '';
    setting1 = widget.program?.setting1 ?? '';
    setting2 = widget.program?.setting2 ?? '';
    setting3 = widget.program?.setting3 ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('edit'),
          actions: [buildButton(), deleteButton()],
        ),
        body: Form(
          key: _formKey,
          child: ProgramFormWidget(
            isImportant: isImportant,
            number: number,
            title: title,
            description: description,
            settings1: setting1,
            settings2: setting2,
            settings3: setting3,
            onChangedImportant: (isImportant) =>
                setState(() => this.isImportant = isImportant),
            onChangedNumber: (number) => setState(() => this.number = number),
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedDescription: (description) =>
                setState(() => this.description = description),
            onChangedSetting1: (settings1) =>
                setState(() => setting1 = settings1),
            onChangedSetting2: (settings2) =>
                setState(() => setting2 = settings2),
            onChangedSetting3: (settings3) =>
                setState(() => setting3 = settings3),
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: isFormValid ? null : Colors.amber,
        ),
        onPressed: addOrUpdateProgram,
        child: const Text('Save'),
      ),
    );
  }

  void addOrUpdateProgram() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.program != null;

      if (isUpdating) {
        await updateProgram();
      } else {
        await addProgram();
      }

      Navigator.of(context).pop();
    }
  }

  Widget deleteButton() => IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          //  await ProgramDatabase.instance.delete(widget.note!.id);

          Navigator.of(context).pop();
        },
      );
  Future updateProgram() async {
    final note = widget.program!.copy(
      isImportant: isImportant,
      number: number,
      title: title,
      description: description,
      setting1: setting1,
      setting2: setting2,
      setting3: setting3,
    );

    await ProgramDatabase.instance.update(note);
  }

  Future addProgram() async {
    final note = Program(
      title: title,
      isImportant: true,
      number: number,
      description: description,
      createdTime: DateTime.now(),
      setting1: setting1,
      setting2: setting2,
      setting3: setting3,
    );

    await ProgramDatabase.instance.create(note);
  }
}
