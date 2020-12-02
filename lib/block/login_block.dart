import 'dart:async';

import 'package:flutter_app/block/model/user.dart';
import 'package:rxdart/rxdart.dart';

import 'base/bloc_base.dart';

class LoginBlock extends BlocBase {

  final StreamController<bool> _password = BehaviorSubject<bool>();
  final StreamController<bool> _email = BehaviorSubject<bool>();
  final StreamController<bool> _fullName = BehaviorSubject<bool>();
  final StreamController<bool> _isLoading = StreamController<bool>.broadcast();

  Stream<bool> get isPasswordValid => _password.stream;

  Stream<bool> get isEmailValid => _email.stream;

  Stream<bool> get isFullNameValid => _fullName.stream;

  Stream<bool> get isLoading => _isLoading.stream;

  Future<UserLogin> signUpAction(String password, String email) async {
    _isLoading.add(true);

    await Future.delayed(Duration(milliseconds: 500)); // a simulated delay

    _email.add(_isEmailValid(email));
    _password.add(_isPasswordValid(password));

    if (!_isEmailValid(email) || !_isPasswordValid(password)) {
      _isLoading.add(false);
      return null;
    }
    print("Do login withParams :" + password + "," + email);

    await Future.delayed(Duration(seconds: 5)); // a simulated delay
    _isLoading.add(false);
    return UserLogin.forSignUp(email, password);
  }

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
    _password.add(_isPasswordValid(password));

    if (!_isFullNameValid(fullName) ||
        !_isEmailValid(email) ||
        !_isPasswordValid(password)) {
      _isLoading.add(false);
      return null;
    }
    print("Do login withParams :" + fullName + "," + password + "," + email);

    await Future.delayed(Duration(seconds: 1)); // a simulated delay
    _isLoading.add(false);
    return UserLogin(fullName, email, password);
  }

  bool _isFullNameValid(String fullName) {
    return fullName.length > 2;
  }

  bool _isEmailValid(String email) {
    return email.contains("@");
  }

  bool _isPasswordValid(String password) {
    return password.length > 4;
  }
}
