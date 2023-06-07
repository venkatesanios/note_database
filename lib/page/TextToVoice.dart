import 'package:flutter/material.dart';
import 'package:note_database/src/texttovoice.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Text to Speach'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          TextField(
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
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
            child: Text('speach'),
            onPressed: () {
              speaktovoice.speak(typetext.text);
            },
          ),
        ],
      ),
    );
  }
}
