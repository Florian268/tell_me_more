import 'package:flutter/material.dart';
import '../models/exhibit.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';


class ExhibitView extends StatefulWidget {
  const ExhibitView({super.key});
  @override
  State<ExhibitView> createState() => _ExhibitViewState();
}


class _ExhibitViewState extends State<ExhibitView>  {

  late OpenAI openAI;

  @override
  void initState() {
    openAI = OpenAI.instance.build(
        token: "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",
        baseOption: HttpSetup(
            receiveTimeout: const Duration(seconds: 10),
            connectTimeout: const Duration(seconds: 10)),
        isLog: true);
    super.initState();
  }

  String GPT_Output = "";

  @override
  Widget build(BuildContext context) {
    Exhibit exhibit = ModalRoute.of(context)!.settings.arguments as Exhibit;
    final _text = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
        title: const Text("Exhibit"),
      ),
      body:
      Center(
      child: Column(
        children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Text(exhibit.exhibitName, style: TextStyle(fontSize: 25),),
                      SizedBox(height: 10),
                      Container(
                        alignment: Alignment.center,
                        width: 340,
                          child: Text(exhibit.exhibitContext, style: TextStyle(fontSize: 20),)
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 340,
                      child: TextField(
                        controller: _text,
                        decoration: InputDecoration(
                          labelText: 'Enter a question',
                        ),
                      ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          String question = "context" + exhibit.exhibitContext + "/n" + _text.text;
                          String data = await _chatGpt3(question);

                          setState(() {
                            GPT_Output = data;
                          });
                        },
                        child: Text('Ask GPT'),
                      ),
                      SizedBox(height: 20),
                      Container(
                          alignment: Alignment.center,
                          width: 340,
                          child: Text(GPT_Output, style: TextStyle(fontSize: 20),)
                      ),
                    ],
                  ),
                ),
        ],
      )
      ),
      );
  }

  Future<String> _chatGpt3(String question) async {
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
}