import 'package:flutter/cupertino.dart';

class UserLogin {
  String fullName;
  String email;
  String password;

  UserLogin(this.fullName, @required this.email, @required this.password);

  UserLogin.forSignUp(@required _email, @required _password) {
    this.email = _email;
    this.password = _password;
  }

  UserLogin.forSignIn(@required _fullName, @required _email, @required _password) {
    this.fullName = _fullName;
    this.email = _email;
    this.password = _password;
  }

  bool isSignInInputDataValid() {
    if (fullName != null && email != null && password != null) {
      return true;
    }
    return false;
  }
}
