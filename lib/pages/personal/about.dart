import 'package:flutter/material.dart';
import 'package:myapp/widget/CommonBackBar.dart';
import 'package:myapp/widget/PageWrap.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  bool pageLoading = true;

  List<Widget> renderContent() {
    List<Widget> list = [];
    list.add(WebView(
      // initialUrl: "assets/static/test.html",
      initialUrl: 'https://www.baidu.com',
      javascriptMode: JavascriptMode.unrestricted,
      onPageFinished: (String value) {
        setState(() {
          pageLoading = false;
        });
      },
    ));

    if (pageLoading) {
      list.add(Center(child: CircularProgressIndicator()));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return PageWrap(
        header: CommonBackBar(extra: '返回'),
        body: Stack(
          children: renderContent(),
        ));
  }
}
