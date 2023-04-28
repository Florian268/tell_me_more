import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tell_me_more/views/scanner_view.dart';

import '../models/configuration_model.dart';
import '../view_models/user_view_model.dart';

class InstructionView extends StatefulWidget {
  const InstructionView({super.key});

  @override
  State<InstructionView> createState() => _InstructionViewState();
}

class _InstructionViewState extends State<InstructionView> {
  late int _value;
  late UserViewModel userViewModel;

  @override
  Widget build(BuildContext context) {
     userViewModel = Provider.of<UserViewModel>(context, listen: true);
     _value = AgeState.values.indexOf(userViewModel.getAge());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Instructions'),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.only(top: 100),
                width: 310.0,
                child: const Text(
                  "Welcome to your virtual tour guide.",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                )),
            Container(
                padding: const EdgeInsets.only(top: 30, bottom: 40),
                width: 310.0,
                child: const Text(
                  "Please scan an Exhibit then ask your phone a question about it.",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                )),
            ageSelector(_value),
            IconButton(
                padding: const EdgeInsets.only(top: 30),
                icon: Image.asset('assets/images/scan_anim02.gif'),
                iconSize: 200,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const ScannerView();
                  }));
                }),
          ]),
      ),
    );
  }

  Widget ageSelector(int _value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('Select your age'),
        const SizedBox(height: 10.0),
        Wrap(
          spacing: 5.0,
          children: List<Widget>.generate(
            AgeState.values.length,
            (int index) {
              return ChoiceChip(
                label: Text(AgeState.values[index].name),
                selected: _value == index,
                onSelected: (bool selected) {
                  setState(() {
                    if(selected){
                      _value = index;
                    }
                    userViewModel.setAge(AgeState.values[index]);
                  });
                },
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
