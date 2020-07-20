import 'package:flutter/material.dart';
import 'package:myapp/module/source.dart';
import 'package:myapp/pages/source/sourceDetail.dart';
import 'package:myapp/utils/utils.dart';

class SourceBox extends StatelessWidget {
  final SourceItemModule source;

  SourceBox({this.source});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          routerGo(context, SourceDetailPage(id: source.id));
        },
        child: Card(
            child: PhysicalModel(
                color: Colors.transparent,
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(5.0),
                child:
                    Stack(alignment: Alignment.bottomLeft, children: <Widget>[
                  Image.network(source.cover),
                  Row(children: <Widget>[
                    Expanded(
                        child: Title(title: '${source.type}/${source.tag}'))
                  ])
                ]))));
  }
}

class Title extends StatelessWidget {
  final String title;
  Title({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xFF000000), Colors.transparent],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        )),
        child: Text(title,
            style: TextStyle(color: Colors.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis));
  }
}
