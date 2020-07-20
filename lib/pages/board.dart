import 'package:flutter/material.dart';
import 'package:myapp/dao/comment.dart';
import 'package:myapp/module/comment.dart';
import 'package:myapp/pages/layout/comment.dart';
import 'package:myapp/utils/utils.dart';
import 'package:myapp/widget/Loading.dart';
import 'package:myapp/widget/PageWrap.dart';
import 'package:myapp/widget/commentList.dart';
import 'package:myapp/widget/icon.dart';

class BoardPage extends StatefulWidget {
  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  int page = 1;
  int total = 0;
  List<CommentItemModule> comments = [];
  bool loading = true;

  getdata([bool reload = false]) {
    CommentDao.fetchBoards(page).then((res) {
      if (reload) {
        setState(() {
          total = res.total;
          comments = res.list;
          loading = false;
        });
      } else {
        setState(() {
          total = res.total;
          comments.addAll(res.list);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getdata(true);
  }

  Future<Null> refresh() async {
    page = 1;
    getdata(true);

    return null;
  }

  void getMore() {
    page = page + 1;

    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return PageWrap(
        header: Row(children: <Widget>[
          Text('留言板($total)', style: TextStyle(fontSize: 20.0))
        ]),
        body: LoadingContainer(
            isLoading: loading,
            child: CommentList(
                data: comments,
                total: total,
                onRefresh: refresh,
                getMore: getMore,
                isBorad: true)),
        button: FloatingActionButton(
            onPressed: () async {
              final res =
                  await routerGo(context, CommentPages(type: 3, host: 0));

              if (res != null && res) {
                refresh();
              }
            },
            backgroundColor: Colors.black,
            tooltip: '新增留言',
            child: LiftIcon(code: 0xe8cb, color: Colors.white, size: 22.0)));
  }
}
