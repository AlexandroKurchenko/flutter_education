import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/block/base/bloc_provider.dart';
import 'package:flutter_app/block/home_block.dart';

import '../../../main.dart';

class RewardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  HomeBlock block;
  int currentSegment = 0;

  @override
  void initState() {
    block = BlocProvider.of<HomeBlock>(context);
    super.initState();
  }

  void _onLogOut() {
    print("log out");
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AuthPage()),
    );
  }

  void onValueChanged(int newValue) {
    setState(() {
      currentSegment = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final slidingChildren = <int, Widget>{
      0: Text("Indigo"),
      1: Text("Teal"),
      2: Text("Cyan"),
    };

    return Scaffold(
      body: Column(children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: SizedBox(
            width: double.infinity,
            child: CupertinoSlidingSegmentedControl(
              children: slidingChildren,
              onValueChanged: onValueChanged,
              groupValue: currentSegment,
            ),
          ),
        ),
        Center(
          child: RaisedButton(
            child: Text("Hit me to logout"),
            onPressed: _onLogOut,
          ),
        ),
      ]),
    );
  }
}
