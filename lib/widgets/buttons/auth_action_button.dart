// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class AuthActionButton extends StatelessWidget {
  final String _buttonText;
  final Function clickAction;

  AuthActionButton(this._buttonText, this.clickAction);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 23),
      child: SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>("#00AFCD".toColor())),
            child: Text(_buttonText),
            onPressed: () {
              // signInAction()
              clickAction();
            },
          )),
    );
  }
}

extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}
