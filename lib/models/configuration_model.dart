enum AgeState { unspecified, child, teen, adult }
enum Guide { defaultGuide, guide1, guide2, guide3 }

class ConfigurationModel{
  late AgeState _age;
  late bool _dataCollection;

  ConfigurationModel(){
    _age = AgeState.unspecified;
    _dataCollection = false;
  }

  bool getDataCollection(){
    return _dataCollection;
  }

  void setDataCollection(bool value){
    _dataCollection = value;
  }

  AgeState getAge(){
    return _age;
  }

  setAge(AgeState age){
    _age = age;
  }
}