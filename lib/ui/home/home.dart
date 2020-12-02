import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/block/base/bloc_provider.dart';
import 'package:flutter_app/block/home_block.dart';
import 'package:flutter_app/block/model/user.dart';

import 'first_screen.dart';

class Home extends StatefulWidget {
  final UserLogin userLogin;

  Home(this.userLogin, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeState(userLogin);
}

class _HomeState extends State<Home> {
  final UserLogin userLogin;

  _HomeState(this.userLogin)

  @override
  Widget build(BuildContext context) {
    final HomeBlock bloc = HomeBlock(userLogin);
    final FirstScreen screen = FirstScreen();

    return BlocProvider(
      child: screen,
      bloc: bloc,
    );
  }
}
