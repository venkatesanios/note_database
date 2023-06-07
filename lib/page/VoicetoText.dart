import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as speechToText;

import '../src/texttovoice.dart';

class VoicetoText extends StatelessWidget {
  const VoicetoText({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const VoicetoTextPage();
  }
}

class VoicetoTextPage extends StatefulWidget {
  const VoicetoTextPage({super.key});

  @override
  _VoicetoTextPageState createState() => _VoicetoTextPageState();
}

class _VoicetoTextPageState extends State<VoicetoTextPage> {
  late speechToText.SpeechToText speech;
  String textString = "Press The Button";
  bool isListen = false;
  double confidence = 1.0;
  SpeakText speaktovoice = SpeakText();

  void startListening() async {
    speaktovoice.speak('Start');
    bool available = await speech.initialize();
    if (available) {
      setState(() {
        isListen = true;
      });
      speech.listen(
        onResult: (value) {
          setState(() {
            textString = value.recognizedWords;
            if (value.hasConfidenceRating && value.confidence > 0) {
              confidence = value.confidence;
            }
          });
        },
      );
    }
  }

  void stopListening() {
    setState(() {
      isListen = false;
    });
    speech.stop();
    speaktovoice.speak('End');
  }

  @override
  void initState() {
    super.initState();
    speech = speechToText.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Speech To Text"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          Container(
            child: Text(
              "Confidence: ${(confidence * 100.0).toStringAsFixed(1)}%",
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              textString,
              style: const TextStyle(
                fontSize: 25.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: GestureDetector(
        onLongPress: startListening,
        onLongPressEnd: (details) => stopListening(),
        child: FloatingActionButton(
          backgroundColor: isListen ? Colors.green : Colors.grey,
          onPressed: () {},
          child: !isListen
              ? const Icon(
                  Icons.mic,
                  color: Colors.white,
                )
              : const Icon(
                  Icons.mic_none,
                  color: Colors.black,
                ),
        ),
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as speechToText;

import '../src/texttovoice.dart';

class VoicetoText extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return VoicetoTextPage();
  }
}

class VoicetoTextPage extends StatefulWidget {
  @override
  _VoicetoTextPageState createState() => _VoicetoTextPageState();
}

class _VoicetoTextPageState extends State<VoicetoTextPage> {
  late speechToText.SpeechToText speech;
  String textString = "Press The Button";
  bool isListen = false;
  double confidence = 1.0;
  SpeakText speaktovoice = SpeakText();

  void listen() async {
    speaktovoice.speak('Start');
    if (!isListen) {
      bool avail = await speech.initialize();
      if (avail) {
        setState(() {
          isListen = true;
        });
        speech.listen(onResult: (value) {
          setState(() {
            textString = value.recognizedWords;
            if (value.hasConfidenceRating && value.confidence > 0) {
              confidence = value.confidence;
            }
          });
        });
      }
    } else {
      setState(() {
        isListen = false;
      });
      speech.stop();
      speaktovoice.speak('end');
    }
  }

  @override
  void initState() {
    super.initState();
    speech = speechToText.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Speech To Text"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10.0,
          ),
          Container(
            child: Text(
              "Confidence: ${(confidence * 100.0).toStringAsFixed(1)}%",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              textString,
              style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: isListen
            ? Icon(
                Icons.mic,
                color: Colors.white,
              )
            : Icon(
                Icons.mic_none,
                color: Colors.black,
              ),
        backgroundColor: isListen ? Colors.green : Colors.grey,
        onPressed: () {
          listen();
        },
      ),
    );
  }
}*/