import 'package:flutter/material.dart';

class TextFormStream extends StatefulWidget {
  final TextEditingController _controller;
  final Stream<bool> _isValidDataStream;

  TextFormStream(this._controller, this._isValidDataStream);

  @override
  _TextFormStreamState createState() => _TextFormStreamState(_controller, _isValidDataStream);
}

class _TextFormStreamState extends State<TextFormStream> {
  final TextEditingController _controller;
  final Stream<bool> _isValidDataStream;

  _TextFormStreamState(this._controller, this._isValidDataStream);

  MaterialAccentColor _getColorForField(AsyncSnapshot<bool> isFieldValid) {
    if (isFieldValid.data != null && isFieldValid.data) {
      return Colors.blueAccent;
    } else {
      return Colors.redAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: true,
        stream: _isValidDataStream,
        builder: (BuildContext context, AsyncSnapshot<bool> snapShot) {
          if (snapShot.hasData) {
            return TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: _getColorForField(snapShot),
                      // color: Colors.blueAccent,
                      width: 1.0),
                ),
                border: OutlineInputBorder(),
              ),
              // ),
            );
          }
          return Container(width: 0.0, height: 0.0);
        });
  }
}
