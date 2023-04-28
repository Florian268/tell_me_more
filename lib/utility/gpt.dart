import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/cupertino.dart';

import '../models/exhibit_model.dart';

class Gpt{
  late OpenAI openAI;

  Gpt(String token){
    openAI = OpenAI.instance.build(
        token: token,
        baseOption: HttpSetup(
            receiveTimeout: const Duration(seconds: 20),
            connectTimeout: const Duration(seconds: 20)),
        isLog: true);
  }

  Future<String> chatGpt3(String question) async {
    final request = ChatCompleteText(messages: [
      Map.of({"role": "user", "content": question})
    ], maxToken: 200, model: kChatGptTurbo0301Model);

    final response = await openAI.onChatCompletion(request: request);
    String responseString = "";
    for (var element in response!.choices) {
      responseString += ("${element.message.content}");
    }
    return responseString;
  }

  Widget checkOutputFormat(ExhibitModel exhibit, String gpt_output) {
    if(exhibit.qrType == 1){
      return Text("this has currently been disabled");
      //return (_futureAlbum == null) ? Text("") : buildFutureBuilder();
    }else{
      return Text(gpt_output, style: TextStyle(fontSize: 20));
    }
  }
}