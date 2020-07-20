import 'package:flutter/material.dart';

class HomeSkeleton extends StatefulWidget {
  final double height;
  final double width;
  HomeSkeleton({Key key, this.height = 20, this.width = 200}) : super(key: key);
  @override
  State<StatefulWidget> createState() => SkeletonState();
}

class SkeletonState extends State<HomeSkeleton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation gradientPosition;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    gradientPosition = Tween<double>(
      begin: -3,
      end: 10,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    )..addListener(() {
        setState(() {});
      });

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment(gradientPosition.value, 0),
              end: Alignment(-1, 0),
              colors: [Colors.black, Colors.black26, Colors.black])),
    );
  }
}
