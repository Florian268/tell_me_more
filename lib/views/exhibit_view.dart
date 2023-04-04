import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/llm_view_model.dart';

class ExhibitView extends StatefulWidget {
  const ExhibitView({super.key});
  @override
  State<ExhibitView> createState() => _ExhibitViewState();
}

class _ExhibitViewState extends State<ExhibitView> {

  late LlmViewModel viewModel;
  final _text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<LlmViewModel>(context, listen: true);
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
                      const SizedBox(height: 10),
                      Text(viewModel.getExhibitName(), style: const TextStyle(fontSize: 25),),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 340,
                      child: TextField(
                        controller: _text,
                        decoration: const InputDecoration(
                          labelText: 'Enter a question',
                        ),
                      ),
                      ),
                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                      IconButton(
                        icon: const Icon(Icons.spatial_audio),
                        onPressed: () {
                          setState(() async {
                            viewModel.startTts(viewModel.getLlmResponse());
                          });
                         },
                       ),
                      // Text('play'),

                          IconButton(
                            icon: const Icon(Icons.stop),
                            onPressed: () {
                              setState(() async {
                                viewModel.stopTts();
                              });
                            },
                          ),

                            IconButton(
                              icon: const Icon(Icons.auto_delete),
                              onPressed: () {
                                viewModel.resetChatHistory();
                              },
                            ),
                          //Text('stop'),
                      ],
                      ),

                      ElevatedButton(
                        onPressed: () async {
                            viewModel.askLlm(_text.text);
                        },
                        child: const Text('Ask GPT'),
                      ),
                      const SizedBox(height: 20),
                      Container(
                          alignment: Alignment.center,
                          width: 340,
                          child: Text(viewModel.getLlmResponse())
                      ),
                    ],
                ),
      ),
      );
  }
}

