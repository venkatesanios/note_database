import 'package:flutter/material.dart';
import 'package:note_database/db/node_database.dart';
import 'package:note_database/model/note.dart';
import 'package:note_database/page/TextToVoice.dart';
import 'package:note_database/page/VoicetoText.dart';
import 'package:note_database/page/checkbox_list.dart';
import 'package:note_database/page/details_note_page.dart';
import 'package:note_database/page/edit_note_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_database/src/texttovoice.dart';
import 'package:note_database/widgets/note_card_widget.dart';
import 'package:flutter_tts/flutter_tts.dart';

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
          elevation: 2.0,
          child: Column(
            children: [
              const UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF80A84F),
                ),
                accountName: Text(
                  'Venkatesan',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
                accountEmail: Text(
                  'venkatesan.niagara@gmail.com',
                  style: TextStyle(fontSize: 14.0, color: Colors.white70),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(
                    'https://www.daysoftheyear.com/cdn-cgi/image/dpr=1%2Cf=auto%2Cfit=cover%2Cheight=675%2Cq=85%2Cwidth=1200/wp-content/uploads/red-rose-day1.jpg',
                  ),
                  //https://www.daysoftheyear.com/cdn-cgi/image/dpr=1%2Cf=auto%2Cfit=cover%2Cheight=675%2Cq=85%2Cwidth=1200/wp-content/uploads/red-rose-day1.jpg
                  // child: Text('NSV'),
                ),
              ),
              ListTile(
                title: const Text('home'),
                onTap: () {},
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
              ListTile(
                title: const Text('Text to Voice'),
                onTap: () {
                  //
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Texttovoice()));
                },
              ),
              ListTile(
                title: const Text('Check box'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyCheckboxList()));
                },
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

  Widget buildNotes() => StaggeredGridView.countBuilder(
        addRepaintBoundaries: true,
        padding: const EdgeInsets.all(8),
        itemCount: notes.length,
        staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final note = notes[index];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NoteDetailPage(noteId: note.id!),
              ));

              // await Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => AddEditNotePage(note: note),
              // ));

              refreshNotes();
            },
            child: NoteCardWidget(note: note, index: index),
          );
        },
      );
}
