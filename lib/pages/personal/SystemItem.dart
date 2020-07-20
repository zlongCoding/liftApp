import 'package:flutter/material.dart';
import 'package:myapp/utils/utils.dart';
import 'package:myapp/widget/icon.dart';

class SystemItem extends StatefulWidget {
  final Widget base;
  final bool haveLine;
  final String extra;
  final Widget router;

  final void Function() action;

  SystemItem(
      {@required this.base,
      this.haveLine = true,
      this.extra,
      this.router,
      this.action});

  @override
  State<StatefulWidget> createState() => _SystemItemState();
}

class _SystemItemState extends State<SystemItem> {
  bool isActive = false;

  Widget renderLeft() {
    List<Widget> list = [];
    if (widget.extra != null) {
      list.add(Text(widget.extra, style: TextStyle(color: Colors.grey)));
      list.add(SizedBox(width: 8.0));
    }
    list.add(LiftIcon(code: 0xe65a));

    return Row(children: list);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.router != null) {
          routerGo(context, widget.router);
        } else {
          widget.action();
        }
      },
      onTapDown: (d) {
        setState(() {
          isActive = true;
        });
      },
      onTapUp: (d) {
        setState(() {
          isActive = false;
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: isActive ? Color(0xffeeeeee) : Colors.white,
            border: widget.haveLine
                ? Border(
                    bottom: BorderSide(width: 1.0, color: Color(0xffeeeeee)))
                : Border(
                    bottom: BorderSide(width: 0.0, color: Colors.transparent))),
        padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[widget.base, renderLeft()],
        ),
      ),
    );
  }
}
