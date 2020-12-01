import 'package:flutter/material.dart';
import '../../widgets/buttons/ImageButton.dart';
import '../../widgets/buttons/AuthActionButton.dart';
import 'sign_in.dart';
class SignUp extends StatefulWidget {
  SignUp({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  void moveTo() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignIn()),
    );
  }

  @override
  Widget build(BuildContext context) {}
}
