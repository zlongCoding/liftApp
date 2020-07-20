import 'dart:async';
import 'package:myapp/config/config.dart';
import 'package:myapp/module/source.dart';
import 'package:myapp/utils/http.dart';

class SourceDao {
  static Future<SourceModule> fetchSource(int page, [String key = '']) async {
    var url = '$base_url/api/movie/getAll?page=$page&key=$key';

    final res = await Http.get(url);

    return SourceModule.fromJson(res['data']);
  }
}
