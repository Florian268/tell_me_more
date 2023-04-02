import 'package:flutter/material.dart';
import 'package:tell_me_more/views/instruction.dart';
import 'package:tell_me_more/views/scanner.dart';

class LandingView extends StatelessWidget {
  const LandingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/gallery.png'),
            fit: BoxFit.cover,
            alignment: Alignment.bottomLeft,
          ),
        ),
        child: Align(
          child: Container(
            alignment: Alignment(0.0, 0.5),
            child: SizedBox(
                height: 65,
                width: 120,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 110, 125),
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const InstructionView();
                      }));
                    },
                    child: const Text('Start!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        )))),
          ),
        ),
      ),
    );
  }
}