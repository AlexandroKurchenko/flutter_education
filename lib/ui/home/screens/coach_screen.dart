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

  List<String> _getListItems() {
    List<String> listData = <String>[];
    for (int i = 0; i < 123; i++) {
      listData.add("Some input text fot index $i");
    }
    return listData;
  }

  List<Widget> _prepareListTitles() {
    List<Widget> listData = <Widget>[];
    _getListItems().forEach((element) {
      listData.add(_wrapElement(element));
    });
    return listData;
  }

  Widget _wrapElement(String element) {
    return Card(
        child: ListTile(
      title: Text(element),
      subtitle: Text("Subtitle"),
      onTap: () {
        _showMeIndex(element);
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scrollbar(
      child: ListView(
        restorationId: "some_id",
        padding: const EdgeInsets.symmetric(vertical: 10),
        children: _prepareListTitles(),
      ),
    ));
  }

  _showMeIndex(String element) {
    print("index is $element");
  }
}
