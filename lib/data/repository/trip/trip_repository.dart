// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:fmbp/data/sources/address.dart';
import 'package:fmbp/data/sources/api/url.dart';
import 'package:fmbp/data/sources/https/https.dart';
import 'package:fmbp/presentation/screens/activity/body.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';

import '../../../models/export_model.dart';
import '../../global/export_global.dart';
import 'package:http/http.dart' as http;

abstract class ITripRepository {
  Future getTrip(String selectDate);

  Future<Response> delTrip(int id);

  Future getFleetMile();

  Future<Response> saveDayTrip(
    int startMile,
    String startTime,
    int endMile,
    String endTime,
    String route,
    String tripMemo,
    int tollFee,
    int parkingFee,
  );
  Future initLocationService();
}

class TripRepository extends ITripRepository {
  var token = globalUser.getToken;

  @override
  Future getTrip(String selectDate) async {
    var body = {
      "approvalStatus": "",
      "bookingNo": "",
      "customerNo": "",
      "dateFrom": selectDate, //"08/12/2022"
      "dateTo": selectDate, //DateFormat('MM/dd/yyyy').format(DateTime.now())
      "fleetDesc": globalDriver.getFleetDesc,
      "isUserVerify": "",
      "StaffId": globalUser.getStaffID,
    };

    final response = await http.post(
      Uri.parse(ConfigServer.configSSO + UrlAPI.getTripRecord),
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      print("DONE");
      var json = jsonDecode(response.body);
      var data = json["payload"].cast<Map<String, dynamic>>() as List;
      var listTripRecord = <TripRecord>[];
      listTripRecord =
          data.map<TripRecord>((json) => TripRecord.fromJson(json)).toList();
      listTripAllDay.clear();
      listTripAllDay.addAll(listTripRecord);
      return "Done";
    } else {
      print("FAIL");
      return "Null";
    }
  }

  @override
  Future<Response> delTrip(int id) async {
    Map map = {};
    map["TRId"] = id;
    final response = await httpPostSSO(UrlAPI.deleteTrip, map);
    if (response.statusCode == 200) {
      print("xóa thành công");
    } else {
      print("xóa không thành công");
    }
    return response;
  }

  @override
  Future getFleetMile() async {
    var token = globalUser.getToken;

    var body = {"FleetDesc": globalDriver.getFleetDesc.toString()};
    if (globalUser.getStaffID != 0) {
      final response = await http.post(
        Uri.parse(ConfigServer.configSSO + UrlAPI.getMile),
        headers: {
          "Content-Type": 'application/json',
          "Authorization": 'Bearer $token'
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var dataMile = jsonResponse["payload"];
        if (dataMile.isNotEmpty) {
          globalMile.setLastMile = jsonResponse["payload"][0]["lastestMile"];
          globalMile.setLastRead = jsonResponse["payload"][0]["lastRead"];
        }
      } else {
        print("FAIL GET MILE");
      }
    } else {
      print("NO");
    }
  }

  @override
  Future<Response> saveDayTrip(
    int startMile,
    String startTime,
    int endMile,
    String endTime,
    String route,
    String tripMemo,
    int tollFee,
    int parkingFee,
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
    map["Fleet_Desc"] = globalDriver.getFleetDesc;
    map["Lat"] = locationServices.getLat;
    map["Lon"] = locationServices.getLon;

    var response = await httpPostSSO(UrlAPI.addDayTrip, map);
    return response;
  }

  @override
  Future initLocationService() async {
    var location = Location();
    if (!await location.serviceEnabled()) {
      if (!await location.requestService()) {
        return;
      }
    }

    var permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) {
        return;
      }
    }
    var loc = await location.getLocation();
    locationServices.setLat = loc.latitude;
    locationServices.setLon = loc.longitude;
    print("${loc.latitude} ${loc.longitude}");
  }
}
