import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  Loader(this._loadingText);

  final String _loadingText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withOpacity(0.92),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(),
          ),
          SizedBox(height: 20),
          Text(
            _loadingText,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
