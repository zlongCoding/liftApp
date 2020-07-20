import 'dart:async';
import 'package:myapp/config/config.dart';
import 'package:myapp/module/common.dart';
import 'package:myapp/utils/http.dart';

class SystemDao {
  static Future<CommonModule> follow(String username, String email) async {
    var url = '$base_url/api/follow/follow';

    var res = await Http.post(url, {'username': username, 'email': email});

    return CommonModule.fromJson(res);
  }

  static Future<VersionModule> getaAppInfo() async {
    var url = '$base_url/api/app/home/getAppInfo';

    final res = await Http.get(url);

    return VersionModule.fromJson(res['data']);
  }
}
