// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:fmbp/data/sources/api/url.dart';

import 'package:fmbp/presentation/screens/inspection/list_inspection.dart';

import '../../../models/export_model.dart';
import '../../global/export_global.dart';
import 'package:http/http.dart' as http;

abstract class IInspectionRepository {
  Future getCheckList();
  // Future<CheckListDetail> getDetail(int clId);
  Future getDetail(int clId);
}

class InspectionRepository extends IInspectionRepository {
  String address = "https://fmbp.enterprise.vn:9110/";

  @override
  Future getCheckList() async {
    // var token = globalUser.getToken;
    var todoDate = DateFormat("yyyy/MM/dd").format(DateTime.now());
    var body = {
      "CheckDateF": "2020/01/01",
      "CheckDateT": todoDate.toString(),
      "createdUser": globalUser.getId,
      "equipmentCode": "",
    };
    final response = await http.post(
      Uri.parse(address + UrlAPI.getListInpection),
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      print("get inspection done");
      var json = jsonDecode(response.body);
      var data = json["payload"].cast<Map<String, dynamic>>() as List;
      var listInspection = <ListInpection>[];
      listInspection = data
          .map<ListInpection>((json) => ListInpection.fromJson(json))
          .toList();
      listAllInspection.clear();
      listAllInspection.addAll(listInspection);
    } else {
      print("Don't get inspection");
    }
    return response;
  }

  @override
  Future getDetail(int clId) async {
    var body = {"clId": clId};

    final response = await http.post(
      Uri.parse(address + UrlAPI.checklistDetails),
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var listdata = json["payload"];
      // print(listdata);
      // listCheckListDetails.clear();
      // listCheckListDetails.addAll(listdata);
    }
    // return listdata;
  }
}
