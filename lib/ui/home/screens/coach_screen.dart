import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/block/base/bloc_provider.dart';
import 'package:flutter_app/block/home_block.dart';

class CoachScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CoachScreenState();
}

class _CoachScreenState extends State<CoachScreen> {
  HomeBlock block;

  @override
  void initState() {
    block = BlocProvider.of<HomeBlock>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Hello user: " + block.userLogin.password + " on CoachScreen."),
      ),
    );
  }
}
