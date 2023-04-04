import 'package:flutter/cupertino.dart';
import '../models/configuration_model.dart';

class UserViewModel with ChangeNotifier {
  late ConfigurationModel config;

  UserViewModel(){
    config = ConfigurationModel();
  }

  getAge(){

  }

  setAge(){

  }
}