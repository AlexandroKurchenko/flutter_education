import 'package:flutter/material.dart';
import 'package:flutter_app/block/login_block.dart';
import 'package:flutter_app/block/model/user.dart';
import 'package:flutter_app/ui/home/home.dart';
import 'package:flutter_app/widgets/input/text_form_stream.dart';

import '../../block/base/bloc_provider.dart';
import '../../widgets/buttons/AuthActionButton.dart';
import '../../widgets/buttons/ImageButton.dart';
import 'sign_up.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  LoginBlock _loginBlock;

  void _moveToSignUp() {
    Navigator.push(
      context,
      FadeRouteBuilder(page: BlocProvider(child: SignUp(), bloc: LoginBlock())),
    );
  }

  void _moveToHome(UserLogin userLogin) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home(userLogin)),
    );
  }

  void _fillForm() {
    _passwordController.text = "someCoolPassword";
    _emailController.text = "email@domain.com";
  }

  void _clearForm() {
    _passwordController.text = "";
    _emailController.text = "";
  }

  Future<void> signInAction() async {
    UserLogin userLoginData = await _loginBlock.signUpAction(
        _passwordController.text, _emailController.text);
    if (userLoginData == null) {
      return;
    }
    _moveToHome(userLoginData);
  }

  Widget _getLoadingWidget() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _getSignInForm() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 150),
          Text(
            'Welcome to App!',
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, left: 25),
            alignment: Alignment.centerLeft,
            child: Text(
              'SIGN UP YOUR SOCIAL NETWORK ACCOUNT',
              style: TextStyle(
                fontSize: 10.0,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 15, left: 25, right: 25),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: ImageButton("images/apple_black.png", _fillForm),
                  flex: 1,
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: ImageButton("images/facebook.png", _clearForm),
                  flex: 1,
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: ImageButton("images/google.png", null),
                  flex: 1,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, left: 25, right: 25),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Email",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormStream(_emailController, _loginBlock.isEmailValid),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, left: 25, right: 25),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Password",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormStream(
                    _passwordController, _loginBlock.isPasswordValid),
              ],
            ),
          ),
          AuthActionButton("SIGN In", signInAction),
          Padding(
            padding: EdgeInsets.only(left: 25, bottom: 25, right: 25),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => {}, // needed
                  child: Text(
                    "FORGOT PASSWORD?",
                    style:
                        TextStyle(fontSize: 10.0, color: "#00AFCD".toColor()),
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () => _moveToSignUp(), // needed
                  child: Text(
                    "SIGN UP",
                    style: TextStyle(
                      color: "#00AFCD".toColor(),
                      fontSize: 10.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text("Copyright 2020"),
          )
        ],
      ),
    );
  }

  Widget _getPageContent() {
    return StreamBuilder(
        initialData: false,
        stream: _loginBlock.isLoading,
        builder: (BuildContext context, AsyncSnapshot<bool> isLoading) {
          if (isLoading.hasData) {
            if (isLoading.data) {
              return _getLoadingWidget();
            } else {
              return _getSignInForm();
            }
          }
          return Container(width: 0.0, height: 0.0);
        });
  }

  @override
  void initState() {
    _loginBlock = BlocProvider.of<LoginBlock>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _getPageContent());
  }
}

class FadeRouteBuilder<T> extends PageRouteBuilder<T> {
  FadeRouteBuilder({Widget page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: Duration(milliseconds: 200),
          transitionsBuilder: (
            context,
            animation,
            secondaryAnimation,
            child,
          ) =>
              FadeTransition(opacity: animation, child: child),
        );
}
