import 'package:flutter/cupertino.dart';
import '../models/exhibit_model.dart';
import '../models/chat_model.dart';
import '../services/gpt.dart';
import '../services/tts.dart';

class LlmViewModel with ChangeNotifier {

  late Tts tts;
  late Gpt gpt;
  late ChatModel chatModel;
  late ExhibitModel exhibit;

  LlmViewModel(String token){
    tts = Tts();
    gpt = Gpt(token);
    chatModel = ChatModel();
  }

  void createNewExhibit(String qr){
    // add method to parse data
    chatModel.setChatHistory("");
    chatModel.setLlmResponse("");
    exhibit = ExhibitModel(qr);
  }

  void askLlm(String question) async {
    // make method to create prompt
    String prompt = "context" + exhibit.exhibitContext + "/n" + chatModel.getChatHistory() + "/n" + question;
    String response = await gpt.chatGpt3(prompt);
    chatModel.setChatHistory(chatModel.getChatHistory() + question + response);
    chatModel.setLlmResponse(response);
    notifyListeners();
  }

  String getLlmResponse(){
    return chatModel.getLlmResponse();
  }

  String getExhibitName() {
    return exhibit.getExhibitName();
  }

  void resetChatHistory() {
    chatModel.setChatHistory("");
  }

  startTts(String text) async {
    var result = await tts.flutterTts.speak(text);
    if (result == 1){
      tts.ttsState = TtsState.playing;
    }
  }

  void stopTts() async {
    var result = await tts.flutterTts.stop();
    if (result == 1){
      tts.ttsState = TtsState.stopped;
    }
  }
}