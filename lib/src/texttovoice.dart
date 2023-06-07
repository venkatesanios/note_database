import 'package:flutter_tts/flutter_tts.dart';

class SpeakText {
  FlutterTts flutterTts = FlutterTts();
  Future<dynamic> speak(String text) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(0.2);
    await flutterTts.speak(text);
  }
}
