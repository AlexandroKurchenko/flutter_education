import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/block/base/bloc_provider.dart';
import 'package:flutter_app/block/login_block.dart';
import 'package:flutter_app/ui/home/home.dart';

import 'block/model/user.dart';
import 'ui/auth/sign_in.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(), //AuthPage(),
    );
  }
}

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoginBlock bloc = LoginBlock();
    final SignIn screen = SignIn();

    return BlocProvider(
      child: screen,
      bloc: bloc,
    );
  }
}

///Needed for debug
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Home(UserLogin("", "", ""));
  }
}
