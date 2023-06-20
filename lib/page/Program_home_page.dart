import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_database/db/program_database.dart';
import 'package:note_database/model/programmodel.dart';
import 'package:note_database/page/edit_program_page.dart';
import 'package:note_database/page/imagePicker.dart';
import 'package:note_database/page/login_page.dart';
import 'package:note_database/page/others.dart';
import 'package:note_database/page/view_program_page.dart';
import 'package:note_database/src/texttovoice.dart';
import 'package:note_database/widgets/program_card_widget.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late List<Program> programs;
  bool isLoading = false;
  FlutterTts flutterTts = FlutterTts();
  SpeakText speaktovoice = SpeakText();
  ImagePicker picker = ImagePicker();
  XFile? image;

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  @override
  void dispose() {
    ProgramDatabase.instance.close();
    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);
    programs = await ProgramDatabase.instance.readAllNotes();
    setState(() => isLoading = false);
  }

  XFile? Profileimage() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Select any option',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.white,
            actions: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  image = await picker.pickImage(source: ImageSource.camera);
                  setState(() {
                    //update UI
                  });
                  Navigator.pop(context, 'OK');
                },
                child: const Text('Open Camera'),
              ),
              TextButton(
                child: const Text('    '),
                onPressed: () {},
              ),
              ElevatedButton(
                onPressed: () async {
                  image = await picker.pickImage(source: ImageSource.gallery);
                  setState(() {});
                  Navigator.pop(context, 'OK');
                },
                child: const Text('Open Gallery'),
              ),
            ],
          );
        });
    return image;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Programs',
            style: TextStyle(fontSize: 24),
          ),
          actions: const [Icon(Icons.search), SizedBox(width: 12)],
        ),
        drawer: Drawer(
          elevation: 70.0,
          backgroundColor: const Color.fromARGB(255, 206, 217, 206),
          surfaceTintColor: Colors.amber,
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xFF80A84F),
                ),
                accountName: const Text(
                  'Venkatesan',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
                accountEmail: const Text(
                  'venkatesan.niagara@gmail.com',
                  style: TextStyle(fontSize: 14.0, color: Colors.white70),
                ),
                currentAccountPicture: InkWell(
                  onTap: () {
                    image = Profileimage();
                    setState(() {
                      //update UI
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: image == null
                        ? const NetworkImage(
                            'https://www.daysoftheyear.com/cdn-cgi/image/dpr=1%2Cf=auto%2Cfit=cover%2Cheight=675%2Cq=85%2Cwidth=1200/wp-content/uploads/red-rose-day1.jpg',
                          )
                        : Image.file(
                            File(image!.path),
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error);
                            },
                          ).image,
                  ),
                ),
              ),
              ListTile(
                title: const Text('home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const Divider(
                height: 1.0,
                color: Color(0xFF80A84F),
                thickness: 1.0,
              ),
              ListTile(
                title: const Text('Voice-To-Text'),
                onTap: () {},
              ),
              const Divider(
                height: 1.0,
                color: Color(0xFF80A84F),
                thickness: 1.0,
              ),
              ListTile(
                title: const Text('Text to Voice'),
                onTap: () {},
              ),
              const Divider(
                height: 1.0,
                color: Color(0xFF80A84F),
                thickness: 1.0,
              ),
              ListTile(
                title: const Text('Myimage'),
                onTap: () {
                  //
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Myimage()));
                },
              ),
              const Divider(
                height: 1.0,
                color: Color(0xFF80A84F),
                thickness: 1.0,
              ),
              ListTile(
                title: const Text('others '),
                onTap: () {
                  //
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Others()));
                },
              ),
              const Divider(
                height: 1.0,
                color: Color(0xFF80A84F),
                thickness: 1.0,
              ),
              ListTile(
                title: const Text('Duplicate create'),
                onTap: () {
                  //
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const DuplicatePage()));
                },
              ),
              const Divider(
                height: 1.0,
                color: Color(0xFF80A84F),
                thickness: 1.0,
              ),
              ListTile(
                title: const Text('Log Out'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
              ),
              const Divider(
                height: 1.0,
                color: Color(0xFF80A84F),
                thickness: 1.0,
              ),
            ],
          ),
        ),
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : programs.isEmpty
                  ? const Text(
                      'No Programs available',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  : buildNotes(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => const AddEditProgramPage()),
            );
            speaktovoice.speak('welcome To Program Page ');
            refreshNotes();
          },
        ),
      );

  Widget buildNotes() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final program = programs[index];
        return GestureDetector(
          onTap: () async {
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProgramDetailPage(noteId: program.id!),
            ));
            refreshNotes();
          },
          child: ProgramListWidget(programs: programs, index: index),
        );
      },
      separatorBuilder: (context, index) => const Divider(
        height: 1,
      ),
      itemCount: programs.length,
    );
  }
}
