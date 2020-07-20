import 'package:flutter/material.dart';
import 'package:myapp/pages/personal/SystemItem.dart';
import 'package:myapp/pages/personal/about.dart';
import 'package:myapp/pages/personal/follow.dart';
import 'package:myapp/utils/updateApp.dart';
import 'package:myapp/widget/Avatar.dart';
import 'package:myapp/widget/Logo.dart';
import 'package:myapp/widget/PageWrap.dart';
import 'package:package_info/package_info.dart';

class PersonalPage extends StatefulWidget {
  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  String version = "1.0.0";

  Future<Null> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });
    return null;
  }

  @override
  void initState() {
    super.initState();
    getVersion();
  }

  @override
  Widget build(BuildContext context) {
    return PageWrap(
        header: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Logo(size: 80.0)]),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10.0),
              SystemItem(
                  base: Avatar(
                      url:
                          'https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png'),
                  haveLine: false,
                  extra: '关于',
                  router: AboutPage()),
              SizedBox(height: 6.0),
              SystemItem(base: Text('订阅我'), router: FollowPage()),
              SystemItem(
                  base: Text('版本信息'),
                  haveLine: false,
                  extra: 'v$version',
                  action: () async {
                    updateApp(context, true);
                  })
            ]));
  }
}
