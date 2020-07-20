import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future routerGo(BuildContext context, Widget router) async {
  return await Navigator.push(
      context, MaterialPageRoute(builder: (context) => router));
}

void saveInfo(String username, String email) async {
  // SharedPreferences.setMockInitialValues({});
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _userinfo = '$username&$email';
  await prefs.setString('userinfo', _userinfo);
}

void removeInfo() async {
  // SharedPreferences.setMockInitialValues({});
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.remove('userinfo');
}

Future<dynamic> getInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var userinfo = prefs.getString('userinfo');

  if (userinfo != null) {
    List<String> _info = prefs.getString('userinfo').split('&');

    return {'username': _info[0], 'email': _info[1]};
  }

  return null;
}

void saveUpdateTime() async {
  // SharedPreferences.setMockInitialValues({});

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String cancelTime = DateTime.now().toString();
  await prefs.setString('updateTime', cancelTime);
}

void removeUpdateTime() async {
  // SharedPreferences.setMockInitialValues({});
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.remove('updateTime');
}

Future<dynamic> getTime() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String time = prefs.getString('updateTime');

  if (time != null) {
    return DateTime.parse(time);
  }

  return null;
}
