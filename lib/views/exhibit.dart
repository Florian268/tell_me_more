import 'package:flutter/material.dart';
import '../classes.dart';
import '../models/exhibit.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExhibitView extends StatefulWidget {
  const ExhibitView({super.key});
  @override
  State<ExhibitView> createState() => _ExhibitViewState();
}

enum TtsState { playing, stopped, paused, continued }

class _ExhibitViewState extends State<ExhibitView>  {
  FlutterTts flutterTts = FlutterTts();
  TtsState ttsState = TtsState.stopped;
  Future<Album>? _futureAlbum;


  late OpenAI openAI;

  @override
  void initState() {
    openAI = OpenAI.instance.build(
        token: "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",
        baseOption: HttpSetup(
            receiveTimeout: const Duration(seconds: 20),
            connectTimeout: const Duration(seconds: 20)),
        isLog: true);
    super.initState();

    flutterTts = FlutterTts();
    flutterTts.setStartHandler(() {
      setState(() {
        print("playing");
        ttsState = TtsState.playing;
      });
    });
    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });
    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
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
       SingleChildScrollView(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.center,
             children: <Widget> [
                      SizedBox(height: 10),
                      Text(exhibit.exhibitName, style: TextStyle(fontSize: 25),),
                      /*
                      SizedBox(height: 10),
                      Container(
                        alignment: Alignment.center,
                        width: 340,
                          child: Text(exhibit.exhibitContext, style: TextStyle(fontSize: 20),)
                      ),
                       */
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                      IconButton(
                        icon: const Icon(Icons.not_started_outlined),
                        onPressed: () {
                          setState(() async {
                            var result = await flutterTts.speak(GPT_Output);
                            if (result == 1) setState(() => ttsState = TtsState.playing);
                          });
                         },
                       ),
                      // Text('play'),

                          IconButton(
                            icon: const Icon(Icons.stop),
                            onPressed: () {
                              setState(() async {
                                var result = await flutterTts.stop();
                                if (result == 1) setState(() => ttsState = TtsState.stopped);
                              });
                            },
                          ),

                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                exhibit.conversation = "";
                              },
                            ),
                          //Text('stop'),
                      ],
                      ),

                      ElevatedButton(
                        onPressed: () async {

                          if(exhibit.qrType == 1) {
                            String httpRequest = exhibit.qr + "&question=" +
                                _text.text;

                            setState(() {
                              _futureAlbum = createAlbum(httpRequest, exhibit);
                            });
                          }else if (exhibit.qrType == 0){
                          String question = "context" + exhibit.exhibitContext + "/n" + exhibit.getConversation() + "/n" + _text.text;
                          String data = await _chatGpt3(question);

                          setState(() {
                            GPT_Output = data;
                            exhibit.conversation =  exhibit.conversation + _text.text + GPT_Output;
                          });

                          }
                        },
                        child: Text('Ask GPT'),
                      ),
                      SizedBox(height: 20),
                      Container(
                          alignment: Alignment.center,
                          width: 340,
                          child: checkOutputFormat(exhibit, GPT_Output)
                      ),
                    ],
                ),
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

  Future<Album> createAlbum(String title, Exhibit exhibit) async {
    final response = await http.post(
      Uri.parse(exhibit.qr),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder<Album>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.title);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }

  Widget checkOutputFormat(Exhibit exhibit, String gpt_output) {
    if(exhibit.qrType == 1){
      return (_futureAlbum == null) ? Text("") : buildFutureBuilder();
    }else{
     return Text(gpt_output, style: TextStyle(fontSize: 20));
    }
  }
}

