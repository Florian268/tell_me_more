enum AgeState { unspecified, child, teen, adult }
class UserModel{
  late AgeState _age;

  userModel(){
    _age = AgeState.unspecified;
  }

  getAge(){
    return _age;
  }

  setAge(AgeState age){
    _age = age;
  }
}