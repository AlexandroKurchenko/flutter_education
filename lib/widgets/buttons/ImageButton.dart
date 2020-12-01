import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final String _imgSource;

  ImageButton(this._imgSource);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => {}, // needed
        child: Container(
          height: 50,
          decoration: new BoxDecoration(
            color: Colors.transparent,
            border: new Border.all(color: Colors.black, width: 1.0),
            borderRadius: new BorderRadius.circular(5.0),
          ),
          child: Center(
            child: Image.asset(
              _imgSource,
              fit: BoxFit.cover,
              height: 35,
              width: 35,
            ),
          ),
        ),
      ),
    );
  }
}
