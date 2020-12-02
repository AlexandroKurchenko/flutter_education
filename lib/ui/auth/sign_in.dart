import 'package:flutter/material.dart';
import 'package:flutter_app/block/login_block.dart';
import 'package:flutter_app/block/model/user.dart';
import 'package:flutter_app/ui/home/home.dart';
import 'package:flutter_app/widgets/input/text_form_stream.dart';
import '../../widgets/buttons/ImageButton.dart';
import '../../widgets/buttons/AuthActionButton.dart';
import 'sign_up.dart';
import '../../block/base/bloc_provider.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _fullNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  LoginBlock _loginBlock;

  void _moveToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUp()),
    );
  }

  Future<void> signInAction() async {
    UserLogin userLoginData = await _loginBlock.signInAction(
        _fullNameController.text,
        _passwordController.text,
        _emailController.text);
    if (userLoginData == null) {
      return;
    }
    _moveToHome(userLoginData);
  }

  void _moveToHome(UserLogin userLogin) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home(userLogin)),
    );
  }

  Widget _getLoadingWidget() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  MaterialAccentColor _getColorForField(AsyncSnapshot<bool> isFieldValid) {
    if (isFieldValid.data != null && isFieldValid.data) {
      return Colors.blueAccent;
    } else {
      return Colors.redAccent;
    }
  }

  Widget _getSignInForm() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 150),
          Text(
            'Create Your Account',
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
            padding: EdgeInsets.only(top: 15, left: 20, right: 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: ImageButton("images/apple_black.png"),
                  flex: 1,
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: ImageButton("images/facebook.png"),
                  flex: 1,
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: ImageButton("images/google.png"),
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
                    "Full Name",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormStream(
                    _fullNameController, _loginBlock.isFullNameValid),
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
          AuthActionButton("SIGN UP", signInAction),
          Padding(
            padding: EdgeInsets.only(
              left: 23,
              bottom: 25,
            ),
            child: Row(
              children: [
                Text(
                  "ALREADY HAVE AN ACCOUNT?",
                  style: TextStyle(
                    fontSize: 10.0,
                  ),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: () => _moveToSignUp, // needed
                  child: Text(
                    "SIGN IN",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 10.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text("Copyright 2020")
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
    _loginBlock = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _getPageContent());
  }
}
