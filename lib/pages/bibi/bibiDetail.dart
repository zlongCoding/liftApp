import 'package:flutter/material.dart';
import 'package:myapp/dao/bibi.dart';
import 'package:myapp/dao/comment.dart';
import 'package:myapp/module/bibi.dart';
import 'package:myapp/module/comment.dart';
import 'package:myapp/pages/bibi/bibiBox.dart';
import 'package:myapp/pages/layout/comment.dart';
import 'package:myapp/utils/utils.dart';
import 'package:myapp/widget/Empty.dart';
import 'package:myapp/widget/PageWrap.dart';
import 'package:myapp/widget/commentList.dart';
import 'package:myapp/widget/icon.dart';
import 'package:myapp/widget/inlineLoading.dart';

class BibiDetailPage extends StatefulWidget {
  final BibiItemModule bibi;

  const BibiDetailPage({Key key, this.bibi}) : super(key: key);

  @override
  _BibiDetailPageState createState() => _BibiDetailPageState();
}

class _BibiDetailPageState extends State<BibiDetailPage> {
  int page = 1;
  int total = 0;
  List<CommentItemModule> comments = [];
  bool loading = true;

  void getComments([bool refresh = false]) {
    CommentDao.fetchByTweet(widget.bibi.id, page).then((res) {
      if (refresh) {
        setState(() {
          total = res.total;
          comments = res.list;
          loading = false;
        });
      } else {
        setState(() {
          total = res.total;
          comments.addAll(res.list);
          loading = false;
        });
      }
    });
  }

  void addLikeNum() {
    BibiDao.likeBibi(widget.bibi.id);
  }

  void getMore() {
    page = page + 1;
    setState(() {
      loading = true;
    });
    getComments();
  }

  void refresh() {
    page = 1;
    getComments(true);
  }

  @override
  void initState() {
    super.initState();
    addLikeNum();
    getComments();
  }

  List<Widget> renderComments() {
    List<Widget> list = [];

    comments.forEach((c) {
      list.add(BibiCommentItem(comment: c, refresh: refresh));
    });

    if (total > comments.length) {
      list.add(SizedBox(height: 2.0));
      list.add(Center(
          child: GestureDetector(
              onTap: () {
                getMore();
              },
              child: Text('加载更多'))));
    }

    if (loading) {
      list.add(InlineLoading());
    }

    return list;
  }

  Widget renderCommentWrap() {
    if (comments.length > 0) {
      return Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              border:
                  Border(top: BorderSide(width: 1.0, color: Color(0xffeeeeee))),
              color: Colors.white),
          child: Column(children: renderComments()));
    }

    return Container(
        margin: EdgeInsets.only(top: 10.0), child: Empty(text: '暂无评论'));
  }

  @override
  Widget build(BuildContext context) {
    return PageWrap(
        header: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        LiftIcon(code: 0xe659, size: 26.0, color: Colors.black),
                        Text('返回')
                      ])),
              GestureDetector(
                  onTap: () async {
                    final res = await routerGo(
                        context, CommentPages(type: 2, host: widget.bibi.id));

                    if (res != null && res) {
                      refresh();
                    }
                  },
                  child: Row(children: <Widget>[
                    LiftIcon(code: 0xe6ba, size: 18.0),
                    SizedBox(width: 4.0),
                    Text('写评论')
                  ]))
            ]),
        body: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView(children: <Widget>[
              BibiBox(data: widget.bibi, isDetail: true),
              renderCommentWrap()
            ])));
  }
}

// ignore: must_be_immutable
class BibiCommentItem extends StatelessWidget {
  final CommentItemModule comment;
  final void Function() refresh;

  BibiCommentItem({this.comment, this.refresh});

  TextStyle userStyle =
      TextStyle(color: Color(0xff1b3349), fontWeight: FontWeight.w400);

  List<Widget> renderContent() {
    List<Widget> content = [];

    content.add(Text(comment.username, style: userStyle));

    if (comment.replyname != null && comment.replyemail != null) {
      content.add(Container(
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          child: Text('回复', style: TextStyle(color: Colors.grey))));

      content.add(Text(comment.replyname, style: userStyle));
    }
    content.add(SizedBox(width: 2.0));
    content.add(Text(':'));
    content.add(SizedBox(width: 2.0));
    content.add(
        Text('(${comment.pubtime})', style: TextStyle(color: Colors.grey)));

    return content;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: GestureDetector(
            onTap: () async {
              final res = await routerGo(
                  context,
                  CommentPages(
                      type: comment.type,
                      host: comment.host,
                      comment: comment));

              if (res != null && res && refresh != null) {
                refresh();
              }
            },
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: renderContent()),
                  SizedBox(height: 4.0),
                  Text(comment.content)
                ])));
  }
}
