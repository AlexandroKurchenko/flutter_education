import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/block/base/bloc_provider.dart';
import 'package:flutter_app/block/home_block.dart';

const CHANNEL_NAME = "com.example.flutter_app";
const CALL_METHOD = "getSpecificInfo";

class CalendarScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  static const methodChannel = const MethodChannel(CHANNEL_NAME);
  HomeBlock block;
  String _resultData = "Unknown";

  @override
  void initState() {
    block = BlocProvider.of<HomeBlock>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Hello user: " + block.userLogin.email + " on Calendar Screen."),
          Center(
            child: kIsWeb
                ? Text("Its browser, so could not fetch from native")
                : ElevatedButton(
                    child: Text("Fetch from native: $_resultData"),
                    onPressed: _getSpecificInfo,
                  ),
          )
        ],
      ),
    ));
  }

  Future<void> _getSpecificInfo() async {
    String resultData;
    try {
      resultData = await methodChannel.invokeMethod(CALL_METHOD);
      print("_getSpecificInfo result $_resultData");
    } on PlatformException catch (e) {
      print("Error happens $e");
    }
    setState(() {
      _resultData = resultData;
    });
  }
}
