import 'package:flutter/material.dart';
import 'package:tell_me_more/views/scanner.dart';

class InstructionView extends StatelessWidget {
  const InstructionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Instructions'),
      ),
      body: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Column(
              children: [
              Container(
              padding: EdgeInsets.only(top:100),
              width: 310.0,

               child: const Text("Welcome to your virtual tour guide.",
                   style: TextStyle(
                    fontSize: 20,

                   ),
                 textAlign: TextAlign.center,

               )
              ),
              Container(
                padding: EdgeInsets.only(top:60),
                width: 310.0,
                child: const Text("Please scan an Exhibit then ask your phone a question about it.",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  textAlign: TextAlign.center,
                )
            ),
              ],
            ),
          IconButton(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top:300),
              icon: Image.asset('assets/images/scan_anim02.gif'),
              iconSize: 500,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const ScannerView();
              }));
            }),
          ]),
    );
  }
}