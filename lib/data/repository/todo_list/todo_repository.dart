// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fmbp/data/global/export_global.dart';
import 'package:fmbp/data/sources/address.dart';
import 'package:fmbp/data/sources/https/https.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../../../models/export_model.dart';
import '../../../presentation/screens/todo_list/body.dart';
import '../../sources/api/url.dart';

abstract class ITodoRepository {
  Future<Response> getTodo();
  Future<Response> acceptTrip(String bookNo, int fleetId);
  Future updatePickUp();
  Future<Response> saveBookTrip(
    int startMile,
    String startTime,
    int endMile,
    String endTime,
    String route,
    String tripMemo,
    int tollFee,
    int parkingFee,
    int brId,
  );
}

class TodoRepository extends ITodoRepository {
  @override
  Future<Response> getTodo() async {
    var todoDate = formatDate(DateTime.now(), [yyyy, '', mm, '', dd]);
    Map map = {};
    map["Equipment"] = globalDriver.getFleetDesc.toString();
    map["TodoDate"] = todoDate.toString();
    final response = await httpPostSSO(UrlAPI.getTodoList.toString(), map);
    if (response.statusCode == 200) {
      print("get todo done");
      var jsonResponseToDo = jsonDecode(response.body);
      var data =
          jsonResponseToDo["payload"].cast<Map<String, dynamic>>() as List;
      if (data.isNotEmpty) {
        var listToDo = <ToDoList>[];
        listToDo =
            data.map<ToDoList>((json) => ToDoList.fromJson(json)).toList();

        todo.clear();
        todo.addAll(listToDo);
      }
    } else {
      print("get todo fail");
    }
    return response;
  }

  @override
  Future<Response> acceptTrip(
    String bookNo,
    int fleetId,
  ) async {
    Map map = {};
    map["BookNo"] = bookNo;
    map["BRId"] = globalAccept.getBrid;
    map["CreateUser"] = globalUser.getId;
    map["FleetId"] = fleetId;
    map["StaffId"] = globalDriver.getStaffID;
    final response = await httpPostSSO(UrlAPI.acceptTrip, map);
    if (response.statusCode == 200) {
      print("save accept done");
    } else {
      print("save accept fail");
    }
    return response;
  }

  @override
  Future updatePickUp() async {
    var token = globalUser.getToken;

    var url = UrlAPI.saveFleetTracking;
    var todoDate = DateFormat('MM/dd/yyyy HH:mm:ss').format(DateTime.now());
    var body = {
      "BRId": globalPickUp.getBrid,
      "EventDate": todoDate,
      "EventType": EventTypeValue.arrivalforPick,
      "PlaceDesc": "",
      "Remark": "Pickup", //"Pickup"
      "Lat": locationServices.getLat, //
      "Lon": locationServices.getLon,
      "UserId": globalUser.getStaffID //globalUser.getStaffId;
    };
    final response = await http.post(
      Uri.parse(ConfigServer.configSSO + url),
      headers: {
        "Content-Type": 'application/json',
        "Authorization": 'Bearer $token'
      },
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      print("pick up");
    } else {
      print("no pick up");
    }
    return response;
  }

  @override
  Future<Response> saveBookTrip(
    int startMile,
    String startTime,
    int endMile,
    String endTime,
    String route,
    String tripMemo,
    int tollFee,
    int parkingFee,
    int brId,
  ) async {
    Map map = {};
    map["StartMile"] = startMile;
    map["StartTime"] = startTime;
    map["EndMile"] = endMile;
    map["EndTime"] = endTime;
    map["CreateUser"] = globalUser.getId;
    map["RouteMemo"] = route;
    map["TripMemo"] = tripMemo;
    map["TollFee"] = tollFee;
    map["ParkingFee"] = parkingFee;
    map["StaffId"] = globalDriver.getStaffID;
    map["BRId"] = brId;
    map["Lat"] = locationServices.getLat;
    map["Lon"] = locationServices.getLon;
    final response = await httpPostSSO(UrlAPI.saveBookTrip, map);
    if (response.statusCode == 200) {
      print("save thành công");
    } else {
      print("save không thành công");
    }
    return response;
  }
}
