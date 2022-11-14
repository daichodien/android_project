// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:fmbp/data/sources/address.dart';
import 'package:fmbp/presentation/screens/inbox/body.dart';
import 'package:http/http.dart' as http;
import 'package:fmbp/data/global/export_global.dart';

import '../../../models/export_model.dart';
import '../../sources/api/url.dart';

abstract class IInboxRepository {
  Future getNotifications();
  int getCountInbox();
  Future delete(int id);
}

class InboxRepository extends IInboxRepository {
  @override
  Future getNotifications() async {
    // String token = globalUser.getToken;
    var userId = globalUser.getIdUserName;
    var getsys = globalUser.getSystemId;
    var messType = "NOTIFICATION";
    var url = "${UrlAPI.getnotifications}$userId/$getsys/$messType";

    final response = await http.get(
      Uri.parse(ConfigServer.configHub + url),
    );
    if (response.statusCode == 200) {
      var dataJson = jsonDecode(response.body);
      var tripTodoJson = dataJson.cast<Map<String, dynamic>>() as List;
      var list = <InbBox>[];
      list = tripTodoJson.map<InbBox>((json) => InbBox.formJson(json)).toList();
      notifiData.clear();
      notifiData.addAll(list);
      print("Có thông báo: ${notifiData.length}");
    } else {
      print("Không có thông báo");
    }
    return response;
  }

  @override
  int getCountInbox() {
    print("còn: ${notifiData.length}");
    return notifiData.length;
  }

  @override
  Future delete(int id) async {
    var url = UrlAPI.deleteNotifications;
    // var id = globalInbox.getId;
    final response = await http.post(
      Uri.parse(ConfigServer.configHub + url + id.toString()),
    );
    return response;
  }
}
