import 'package:flutter/material.dart';
import 'package:myapp/dao/comment.dart';
import 'package:myapp/module/comment.dart';
import 'package:myapp/utils/utils.dart';
import 'package:myapp/widget/EditBottom.dart';
import 'package:myapp/widget/InfoNotice.dart';
import 'package:myapp/widget/Input.dart';
import 'package:myapp/widget/PageWrap.dart';
import 'package:myapp/widget/icon.dart';
import 'package:toast/toast.dart';

class CommentPages extends StatefulWidget {
  final int type;
  final int host;
  final CommentItemModule comment;

  const CommentPages(
      {Key key, @required this.type, @required this.host, this.comment})
      : super(key: key);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPages> {
  TextEditingController contentController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String placeholder = '';

  bool isSave = true;

  void clear() {
    contentController.text = '';
  }

  void getUserInfo() {
    getInfo().then((res) {
      if (res != null) {
        nameController.text = res['username'];
        emailController.text = res['email'];
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    void submit() {
      String content = contentController.text;
      String username = nameController.text;
      String email = emailController.text;

      if (content == '') {
        Toast.show('请输入内容好吗？', context,
            duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      } else if (username == '') {
        Toast.show('请输入你的名字好吗？', context,
            duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      } else if (email == '') {
        Toast.show('请输入你的邮箱好吗？', context,
            duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      } else {
        dynamic params = {};
        if (widget.comment != null) {
          params = {
            'username': username,
            'useremail': email,
            'content': content,
            'host': widget.host,
            'replycontent': widget.comment.content,
            'replyemail': widget.comment.useremail,
            'replyname': widget.comment.username,
            'type': widget.type
          };
        } else {
          params = {
            'username': username,
            'useremail': email,
            'content': content,
            'host': widget.host,
            'type': widget.type
          };
        }
        if (isSave) {
          saveInfo(username, email);
        } else {
          removeInfo();
        }
        CommentDao.addComment(params).then((res) {
          if (res.code == 200) {
            contentController.text = '';
            Toast.show('评论成功', context,
                duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
            Navigator.pop(context, true);
          } else {
            Toast.show(res.msg, context,
                duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
          }
        });
      }
    }

    return PageWrap(
      header: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              children: <Widget>[
                LiftIcon(code: 0xe659, size: 26.0, color: Colors.black),
                Text('返回')
              ],
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Input(
                  maxLine: 6,
                  hintText: widget.comment?.username != null
                      ? '引用 ${widget.comment.username} 的留言'
                      : '',
                  controller: contentController,
                ),
                InfoNotice(text: '您的留言有回复时将会以邮件通知，请正确填写邮箱'),
                Input(require: true, label: '昵称', controller: nameController),
                Input(require: true, label: '邮箱', controller: emailController),
                SaveButton(onChanged: (v) {
                  isSave = v;
                })
              ],
            ),
          ),
          EditBottom(
              submit: submit, clear: clear, cancelText: '清空内容', okText: '提交')
        ],
      ),
    );
  }
}

class SaveButton extends StatefulWidget {
  final void Function(bool v) onChanged;

  const SaveButton({Key key, this.onChanged}) : super(key: key);

  @override
  _SaveButtonState createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  bool isSave = true;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Text('保存信息'),
      Switch(
          value: isSave,
          onChanged: (v) {
            setState(() {
              isSave = v;
            });

            widget.onChanged(v);
          })
    ]);
  }
}
