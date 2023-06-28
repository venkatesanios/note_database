import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_database/RESTApi/test_rest.dart';
import 'package:note_database/Scaner/newqrcodeprint.dart';
import 'package:note_database/Scaner/qr_code.dart';
import 'package:note_database/Scaner/qrcoded/qrmain.dart';
import 'package:note_database/db/node_database.dart';
import 'package:note_database/duplicate/duplicatepage.dart';
import 'package:note_database/imagecompare/image_comparetest.dart';
import 'package:note_database/model/note.dart';
import 'package:note_database/page/TextToVoice.dart';
import 'package:note_database/page/VoicetoText.dart';
import 'package:note_database/page/others.dart';
import 'package:note_database/page/view_program_page.dart';
import 'package:note_database/page/edit_program_page.dart';
import 'package:note_database/page/imagePicker.dart';
import 'package:note_database/page/login_page.dart';
import 'package:note_database/src/texttovoice.dart';
import 'package:note_database/widgets/program_card_widget.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../duplicate/checkexpandpanel.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late List<Note> notes;
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
    NotesDatabase.instance.close();
    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);
    notes = await NotesDatabase.instance.readAllNotes();
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
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const VoicetoText()));
                },
              ),
              const Divider(
                height: 1.0,
                color: Color(0xFF80A84F),
                thickness: 1.0,
              ),
              ListTile(
                title: const Text('Text to Voice'),
                onTap: () {
                  //
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Texttovoice()));
                },
              ),
              // const Divider(
              //   height: 1.0,
              //   color: Color(0xFF80A84F),
              //   thickness: 1.0,
              // ),
              // ListTile(
              //   title: const Text('Myimage'),
              //   onTap: () {
              //     //
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => const Myimage()));
              //   },
              // ),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DuplicatePage()));
                },
              ),
              const Divider(
                height: 1.0,
                color: Color(0xFF80A84F),
                thickness: 1.0,
              ),
              // ListTile(
              //   title: const Text('Expandpanellis create'),
              //   onTap: () {
              //     //
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => Expandpanellis()));
              //   },
              // ),
              // const Divider(
              //   height: 1.0,
              //   color: Color(0xFF80A84F),
              //   thickness: 1.0,
              // ),
              // ListTile(
              //   title: const Text('GenerateQRCode'),
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => const GenerateQRCode()));
              //   },
              // ),
              // const Divider(
              //   height: 1.0,
              //   color: Color(0xFF80A84F),
              //   thickness: 1.0,
              // ),
              // ListTile(
              //   title: const Text('new  GenerateQRCode'),
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => const GenerateQRCode()));
              //   },
              // ),
              // const Divider(
              //   height: 1.0,
              //   color: Color(0xFF80A84F),
              //   thickness: 1.0,
              // ),
              // ListTile(
              //   title: const Text('QR Code Scaner'), //MyHomeQRcode
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => const QRcodeScanner()));
              //   },
              // ),
              // const Divider(
              //   height: 1.0,
              //   color: Color(0xFF80A84F),
              //   thickness: 1.0,
              // ),
              // ListTile(
              //   title: const Text('QR Code all'), //TestApi
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => const MyHomeQRcode()));
              //   },
              // ),
              // const Divider(
              //   height: 1.0,
              //   color: Color(0xFF80A84F),
              //   thickness: 1.0,
              // ),
              ListTile(
                title: const Text('imagecompare'), //
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ImageComparePage()));
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
              : notes.isEmpty
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
              MaterialPageRoute(builder: (context) => const AddEditNotePage()),
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
        final note = notes[index];
        return GestureDetector(
          onTap: () async {
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NoteDetailPage(noteId: note.id!),
            ));
            refreshNotes();
          },
          child: ProgramListWidget(notes: notes, index: index),
        );
      },
      separatorBuilder: (context, index) => const Divider(
        height: 1,
      ),
      itemCount: notes.length,
    );
  }
}
