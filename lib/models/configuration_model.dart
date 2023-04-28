import 'dart:io';
import 'package:path_provider/path_provider.dart';

enum AgeState { unspecified, child, teen, adult }
enum Guide { defaultGuide, guide1, guide2, guide3 }

class ConfigurationModel{
  late AgeState age = AgeState.unspecified;
  late bool _dataCollection;

  ConfigurationModel(){
    _dataCollection = false;
    age = getAge();
  }

  _write(String text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/my_file.txt');
    await file.writeAsString(text);
  }

  Future<String> _read() async {
    String text = "Couldn't read file";
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/my_file.txt');
      text = await file.readAsString();
    } catch (e) {
      print("Couldn't read file");
    }
    return text;
  }

  bool getDataCollection(){
    return _dataCollection;
  }

  void setDataCollection(bool value){
    _dataCollection = value;
  }

  AgeState getAge() {
    print("read + getting age");
    _read().then((value){
      if(value != "Couldn't read file") {
        print("read " + value);
        age = AgeState.values.byName(value);
      }
    });
    return age;
  }

  setAge(AgeState newAge){
    print("newAge " + newAge.name);
    _write(newAge.name);
    age = newAge;
  }
}