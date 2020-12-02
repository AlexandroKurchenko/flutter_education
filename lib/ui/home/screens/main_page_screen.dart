import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/block/base/bloc_provider.dart';
import 'package:flutter_app/block/home_block.dart';

class MainPageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen> {
  HomeBlock block;
  final RegExp _phoneRegex = RegExp(r"^\+{1}\d{10,17}");
  final TextEditingController _controller = TextEditingController();
  final _textKey = GlobalKey<FormState>();

  @override
  void initState() {
    block = BlocProvider.of<HomeBlock>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 36.0),
          child: Form(
            key: _textKey,
            child: TextFormField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  hintText: block.userLogin.email,
                  contentPadding: EdgeInsets.all(24.0),
                  fillColor: Colors.blueGrey.withOpacity(0.3),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      borderSide: BorderSide(color: Colors.blueGrey))),
              controller: _controller,
              validator: (str) {
                var _errorString;
                if (str.isEmpty) {
                  _errorString = "err_empty_field";
                } else if (!_phoneRegex.hasMatch(str) ||
                    _phoneRegex.stringMatch(str) != str) {
                  _errorString = "err_invalid_phone";
                }
                return _errorString;
              },
              onFieldSubmitted: (str) {
                // if (_textKey.currentState.validate())
                //   widget.callback(_controller.text);
              },
            ),
            onChanged: () {
                _textKey.currentState.validate();
            },
          ),
        ),
        RaisedButton(
          color: Colors.teal,
          textColor: Colors.white,
          onPressed: () {
            _textKey.currentState.validate();
          },
          child: Text("btn_login"),
        )
      ],
    );
  }
}
