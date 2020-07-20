import 'package:flutter/material.dart';

class LoadMore extends StatelessWidget {
  final bool hasMore;

  const LoadMore(bool bool, {Key key, this.hasMore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70.0,
        child: Center(
            child: Text('————已经到底啦(┬＿┬)↘————',
                style: TextStyle(color: Colors.grey))));
  }
}
