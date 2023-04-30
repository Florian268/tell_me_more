import 'dart:io';

enum AgeState { unspecified, child, teen, adult }
enum Guide { defaultGuide, guide1, guide2, guide3 }

class ConfigurationModel{
  late AgeState age;
  late bool _dataCollection;

  ConfigurationModel(){
    _dataCollection = false;
    age = AgeState.unspecified;
  }

  bool getDataCollection(){
    return _dataCollection;
  }

  void setDataCollection(bool value){
    _dataCollection = value;
  }

  AgeState getAge() {
    return age;
  }

  setAge(AgeState newAge){
    age = newAge;
  }
}