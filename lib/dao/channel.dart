import 'dart:async';
import 'package:myapp/config/config.dart';
import 'package:myapp/module/channel.dart';
import 'package:myapp/utils/http.dart';

class ChannelDao {
  static Future<List> fetchChannels() async {
    var url = '$base_url/api/channel/getAllChannel';

    final res = await Http.get(url);
    List<ChannelModel> list = [];
    res['data'].forEach((c) {
      list.add(ChannelModel.fromJson(c));
    });

    return list;
  }
}
