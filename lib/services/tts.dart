import 'package:flutter_tts/flutter_tts.dart';

enum TtsState { playing, stopped, paused, continued }

class Tts{
  FlutterTts flutterTts = FlutterTts();
  TtsState ttsState = TtsState.stopped;

  Tts(){
    flutterTts = FlutterTts();
    flutterTts.setStartHandler(() {

        print("playing");
        ttsState = TtsState.playing;
    });
    flutterTts.setCompletionHandler(() {
        print("Complete");
        ttsState = TtsState.stopped;
    });
    flutterTts.setErrorHandler((msg) {
        print("error: $msg");
        ttsState = TtsState.stopped;
    });
  }
}