import 'dart:convert';

import 'package:fmbp/data/global/export_global.dart';
import 'package:fmbp/data/sources/address.dart';
import 'package:fmbp/data/sources/api/url.dart';
import 'package:fmbp/models/export_model.dart';
import 'package:fmbp/presentation/screens/home/announcements/index.dart';
import 'package:http/http.dart' as http;

abstract class IAnnouncementsRepository {
  Future getAnn();
}

class AnnouncementsRepository extends IAnnouncementsRepository {
  @override
  Future getAnn() async {
    var token = globalUser.getToken;

    var id = globalUser.getId;

    var url = "${UrlAPI.getAnnouncements}$id";
    final response = await http.get(
      Uri.parse(ConfigServer.configSSO + url),
      headers: {
        "Content-Type": 'application/json',
        "Authorization": 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      var dataFullJson = jsonDecode(response.body);
      var data = dataFullJson["payload"].cast<Map<String, dynamic>>() as List;
      //Tạo list
      var listAnn = <Announcement>[];
      listAnn = data
          .map<Announcement>((json) => Announcement.fromJson(json))
          .toList();

      announcement.clear();
      announcement.addAll(listAnn);
      return "Done";
    } else {
      return "Null";
    }
  }
}
