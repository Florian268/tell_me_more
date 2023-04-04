import 'package:flutter/material.dart';
import 'package:tell_me_more/view_models/llm_view_model.dart';
import 'package:tell_me_more/view_models/user_view_model.dart';
import 'views/landing_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<LlmViewModel>(create: (_) => LlmViewModel("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"),),
          ChangeNotifierProvider<UserViewModel>(create: (_) => UserViewModel(),),
        ],
        child: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tell Me More',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LandingView(),
    );
  }
}