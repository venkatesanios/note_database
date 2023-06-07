import 'package:flutter/material.dart';
import 'package:note_database/widgets/program_Add_widget.dart';

import '../db/node_database.dart';
import '../model/note.dart';

class AddEditNotePage extends StatefulWidget {
  final Note? note;


  const AddEditNotePage({
    Key? key,
    this.note,
  }) : super(key: key);
  @override
  _AddEditNotePageState createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
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

    isImportant = widget.note?.isImportant ?? false;
    number = widget.note?.number ?? 0;
    title = widget.note?.title ?? '';
    description = widget.note?.description ?? '';
    setting1 = widget.note?.setting1 ?? '';
    setting2 = widget.note?.setting2 ?? '';
    setting3 = widget.note?.setting3 ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('edit'),
          actions: [buildButton(),deleteButton()],
        ),
        body: Form(
          key: _formKey,
          child: NoteFormWidget(
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
        onPressed: addOrUpdateNote,
        child: const Text('Save'),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }
  Widget deleteButton() => IconButton(
    icon: const Icon(Icons.delete),
    onPressed: () async {
    //  await NotesDatabase.instance.delete(widget.note!.id);

      Navigator.of(context).pop();
    },
  );
  Future updateNote() async {
    final note = widget.note!.copy(
      isImportant: isImportant,
      number: number,
      title: title,
      description: description,
      setting1: setting1,
      setting2: setting2,
      setting3: setting3,
    );

    await NotesDatabase.instance.update(note);
  }

  Future addNote() async {
    final note = Note(
      title: title,
      isImportant: true,
      number: number,
      description: description,
      createdTime: DateTime.now(),
      setting1: setting1,
      setting2: setting2,
      setting3: setting3,
    );

    await NotesDatabase.instance.create(note);
  }
}
