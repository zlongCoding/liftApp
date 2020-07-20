import 'package:flutter/material.dart';
import 'package:myapp/pages/bibi.dart';
import 'package:myapp/pages/board.dart';
import 'package:myapp/pages/home.dart';
import 'package:myapp/pages/personal.dart';
import 'package:myapp/pages/source.dart';
import 'package:myapp/widget/icon.dart';

class NavigatorBar extends StatefulWidget {
  @override
  _BaseState createState() => _BaseState();
}

class _BaseState extends State<NavigatorBar> {
  int _currentIndex = 0;

  PageController _controller = PageController(initialPage: 0);

  final Color _defaultColor = Colors.grey;
  final Color _activeColor = Colors.black;

  BottomNavigationBarItem createNavigationItem(
      int code, String title, int index) {
    return BottomNavigationBarItem(
        icon: LiftIcon(code: code, color: _defaultColor, size: 22.0),
        activeIcon: LiftIcon(code: code, color: _activeColor, size: 22.0),
        title: Text(title,
            style: TextStyle(
                color: _currentIndex != index ? _defaultColor : _activeColor)));
  }

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _controller,
          children: <Widget>[
            HomePage(),
            BibiPage(),
            SourcePage(),
            BoardPage(),
            PersonalPage(),
          ]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          createNavigationItem(0xe8c6, '首页', 0),
          createNavigationItem(0xe8c8, '行博', 1),
          createNavigationItem(0xe8c9, '资源', 2),
          createNavigationItem(0xe8c4, '留言板', 3),
          createNavigationItem(0xe8c5, '关于', 4)
        ],
      ),
    );
    return scaffold;
  }
}

class SystemPage {}
