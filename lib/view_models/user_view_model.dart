import 'package:flutter/cupertino.dart';
import '../models/configuration_model.dart';

class UserViewModel with ChangeNotifier {
  late ConfigurationModel config;

  UserViewModel(ConfigurationModel configurationModel){
    config = configurationModel;
  }

  AgeState getAge(){
    return config.getAge();
  }

  setAge(AgeState age){
    config.setAge(age);
  }
}