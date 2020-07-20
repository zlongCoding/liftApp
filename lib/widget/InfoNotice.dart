import 'package:flutter/material.dart';
import 'package:myapp/widget/icon.dart';

class InfoNotice extends StatelessWidget {
  final String text;

  InfoNotice({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          LiftIcon(code: 0xe8c7),
          SizedBox(width: 6.0),
          Expanded(child: Text(text, style: TextStyle(color: Colors.grey)))
        ],
      ),
    );
  }
}
