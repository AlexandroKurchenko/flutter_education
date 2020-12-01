import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/block/model/User.dart';

import 'base/bloc_base.dart';

class LoginBlock extends BlocBase {
// final UserLogin user = new UserLogin()

  final StreamController<bool> _password = StreamController<bool>.broadcast(sync: true);
  final StreamController<bool> _email = StreamController<bool>.broadcast();
  final StreamController<bool> _fullName = StreamController<bool>.broadcast();
  final StreamController<bool> _isLoading = StreamController<bool>.broadcast();

  Stream<bool> get isPasswordValid => _password.stream;

  Stream<bool> get isEmailValid => _email.stream;

  Stream<bool> get isFullNameValid => _fullName.stream;

  Stream<bool> get isLoading => _isLoading.stream;

  // Sink<String> get inName => _username.sink;

  doSignUp() {}

  @override
  void dispose() {
    _fullName.close();
    _email.close();
    _password.close();
    _isLoading.close();
  }

  Future<UserLogin> signInAction(
      String fullName, String password, String email) async {
    _isLoading.add(true);

    await Future.delayed(Duration(milliseconds: 500)); // a simulated delay

    _fullName.add(_isFullNameValid(fullName));
    _email.add(_isEmailValid(email));
    bool isValid = _isPasswordValid(password);
    _password.add(isValid);

    if (!_isFullNameValid(fullName) ||
        !_isEmailValid(email) ||
        !_isPasswordValid(password)) {
      _isLoading.add(false);
      return null;
    }
    print("Do login withParams :" + fullName + "," + password + "," + email);

    await Future.delayed(Duration(seconds: 5)); // a simulated delay
    _isLoading.add(false);
    return UserLogin(fullName, email, password);
  }

  bool _isFullNameValid(String fullName) {
    return fullName.length > 4;
  }

  bool _isEmailValid(String email) {
    return email.length > 4;
  }

  bool _isPasswordValid(String password) {
    return password.length > 4;
  }
}
