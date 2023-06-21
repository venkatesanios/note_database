import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_database/db/program_database.dart';
import 'package:note_database/model/programmodel.dart';
import 'package:note_database/model/valvemodel.dart';
import 'package:note_database/page/add_editvalve_page.dart';
import 'package:note_database/page/edit_program_page.dart';
import 'package:note_database/widgets/valve_widget.dart';

class ProgramDetailPage extends StatefulWidget {
  final int noteId;

  const ProgramDetailPage({
    Key? key,
    required this.noteId,
  }) : super(key: key);

  @override
  _ProgramDetailPageState createState() => _ProgramDetailPageState();
}

class _ProgramDetailPageState extends State<ProgramDetailPage> {
  late Program program;
  late List<Valve> valve;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNote();
  }

  Future refreshNote() async {
    setState(() => isLoading = true);

    program = await ProgramDatabase.instance.readNote(widget.noteId);
    valve = await ProgramDatabase.instance.readprogramvalve(widget.noteId);

    setState(() => isLoading = false);
    print(widget.noteId);
    print('Valve---- $valve');
    print(valve[0].valvename);
    print(valve[1].valvename);
    print(valve[2].valvename);

    print(program.title);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(program.title),
          actions: [AlertButton(), editButton(), deleteButton()],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      program.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      DateFormat.yMMMd().format(program.createdTime),
                      style: const TextStyle(color: Colors.white38),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      program.description,
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      program.setting1,
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      program.setting2,
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      program.setting3,
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 18),
                    ),
                    const SizedBox(height: 18),
                    //  buildNotes(),
                    Flexible(
                        child: Container(
                      child: buildNotes(),
                    ))
                  ],
                ),
              ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => AddEditValvePage(
                        program: program,
                      )),
            );
          },
        ),
      );

  Widget editButton() => IconButton(
      icon: const Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditProgramPage(program: program),
        ));

        refreshNote();
      });
  Widget AlertButton() => IconButton(
        icon: const Icon(Icons.edit_attributes),
        onPressed: () {
          AlertDialog(
            title: const Text('alert'),
            backgroundColor: Colors.white54,
            content: const Text('Programs '),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          );

          refreshNote();
        },
      );

  Widget deleteButton() => IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          await ProgramDatabase.instance.delete(widget.noteId);

          Navigator.of(context).pop();
        },
      );
  Widget buildNotes() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return GestureDetector(
          // onTap: () async {
          //   await Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => ProgramDetailPage(noteId: program.id!),
          //   ));
          //   refreshNote();
          // },
          child: ValveListWidget(valve: valve, index: index),
        );
      },
      separatorBuilder: (context, index) => const Divider(
        height: 1,
      ),
      itemCount: valve.length,
    );
  }
}
