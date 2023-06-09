import 'package:flutter/material.dart';
import 'package:note_database/Provider/test_provider.dart';
import 'package:note_database/src/texttovoice.dart';
import 'package:provider/provider.dart';

class Texttovoice extends StatefulWidget {
  Texttovoice({super.key});

  @override
  State<Texttovoice> createState() => _TexttovoiceState();
}

class _TexttovoiceState extends State<Texttovoice> {
  TextEditingController typetext = TextEditingController();
  SpeakText speaktovoice = SpeakText();
  @override
  Widget build(BuildContext context) {
    final name = Provider.of<TestProvider>(context, listen: true);
    typetext.text = name.name;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Text to Speach',
          textAlign: TextAlign.justify,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            TextField(
              // onChanged: (value) {
              //   name.namechange(value);
              // },
              controller: typetext,
              maxLines: 3,
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'text here',
                hintStyle: TextStyle(color: Colors.white60),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              child: Text('speach'),
              onPressed: () {
                name.namechange(typetext.text);
                speaktovoice.speak(typetext.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
