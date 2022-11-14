import 'dart:convert';

import 'package:fmbp/data/global/export_global.dart';
import 'package:fmbp/data/sources/address.dart';
import 'package:fmbp/data/sources/api/url.dart';
import 'package:fmbp/models/export_model.dart';
import 'package:http/http.dart' as http;

abstract class IDriverRepository {
  Future<DriverModel> getStaff();
  Future<DriverModel> update(String iCNumber, String licNumber);
  Future deleteAcc();
}

class DriverRepository extends IDriverRepository {
  @override
  Future<DriverModel> getStaff() async {
    String token = globalUser.getToken;

    var url = UrlAPI.getStaff + globalUser.getStaffID.toString();
    var response = await http.get(
      Uri.parse(ConfigServer.configSSO + url),
      headers: {
        "Content-Type": 'application/json',
        "Authorization": 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      print("get staff ok");
      var json = jsonDecode(response.body);
      var payload = json["payload"];
      if (payload != null) {
        globalDriver.setIcNumber = json["payload"]["icNo"];
        globalDriver.setLicenseNumber = json["payload"]["licNumber"];
        globalDriver.setFleetDesc = json["payload"]["fleet_Desc"];

        globalDriver.setStaffID = json["payload"]["staffID"];
        globalDriver.setStaffRole = json["payload"]["staffRole"];
        globalDriver.setEmployeeCode = json["payload"]["employeeCode"];
        globalDriver.setExtLicNumber = json["payload"]["extLicNumber"];
        globalDriver.setStaffNote = json["payload"]["staffNote"];

        globalDriver.setEmergencyContactInfo =
            json["payload"]["emergencyContactInfo"];
        globalDriver.setDateofBirth = json["payload"]["dateofBirth"];
        globalDriver.setDateofJoin = json["payload"]["dateofJoin"];
        globalDriver.setStaffStatus = json["payload"]["staffStatus"];
        globalDriver.setDateOfResign = json["payload"]["dateOfResign"];

        globalDriver.setResignNote = json["payload"]["resignNote"];
        globalDriver.setEnglishLevel = json["payload"]["englishLevel"];
        globalDriver.setCreateDate = json["payload"]["createDate"];
        globalDriver.setCreateUser = json["payload"]["createUser"];
        globalDriver.setUpdateDate = json["payload"]["updateDate"];

        globalDriver.setUpdateUser = json["payload"]["updateUser"];
        globalDriver.setLicenseClass = json["payload"]["licenseClass"];
        globalDriver.setCreateName = json["payload"]["createName"];
        globalDriver.setUpDateName = json["payload"]["upDateName"];
        globalDriver.setAvatarThumbnail = json["payload"]["avatarThumbnail"];

        globalDriver.setLicenseExpDate = json["payload"]["licenseExpDate"];
        globalDriver.setIcNoIssueDate = json["payload"]["icNoIssueDate"];
        globalDriver.setIcNoIssuePlace = json["payload"]["icNoIssuePlace"];
        globalDriver.setLicenseIssueDate = json["payload"]["licenseIssueDate"];
        globalDriver.setForeignLanguage = json["payload"]["foreignLanguage"];
        return DriverModel.fromJson(json);
      } else {
        print("NULL");
      }
    } else {
      print("get fails");
    }
    return const DriverModel();
  }

  @override
  Future<DriverModel> update(String iCNumber, String licNumber) async {
    var body = {
      "staffID": globalDriver.getStaffID,
      "staffName": globalDriver.getFullName,
      "icNo": iCNumber, //113279928|022878977
      "mobileNo": globalDriver.getMobile,
      "staffRole": globalDriver.getStaffRole,
      "licNumber": licNumber,
      "employeeCode": globalDriver.getEmployeeCode,
      "extLicNumber": globalDriver.getExtLicNumber,
      "staffNote": globalDriver.getStaffNote,
      "emergencyContactInfo": globalDriver.getEmergencyContactInfo,
      "dateofBirth": globalDriver.getDateofBirth,
      "dateofJoin": globalDriver.getDateofJoin,
      "staffStatus": globalDriver.getStaffStatus,
      "dateOfResign": globalDriver.getDateOfResign,
      "resignNote": globalDriver.getResignNote,
      "englishLevel": globalDriver.getEnglishLevel,
      "createDate": globalDriver.getCreateDate,
      "createUser": globalDriver.getCreateUser,
      "updateDate": globalDriver.getUpdateDate,
      "updateUser": globalDriver.getUpdateUser, //Người update
      "licenseClass": globalDriver.getLicenseClass,
      "createName": globalDriver.getCreateName,
      "upDateName": globalDriver.getUpDateName, //Tên người update
      "avatarThumbnail": globalDriver.getAvatarThumbnail,
      "licenseExpDate": globalDriver.getLicenseExpDate,
      "icNoIssueDate": globalDriver.getIcNoIssueDate,
      "icNoIssuePlace": globalDriver.getIcNoIssuePlace,
      "licenseIssueDate": globalDriver.getLicenseIssueDate,
      "fleet_Desc": globalDriver.getFleetDesc,
      "foreignLanguage": globalDriver.getForeignLanguage
    };
    String token = globalUser.getToken;

    final response = await http.post(
      Uri.parse(ConfigServer.configSSO + UrlAPI.updateStaff),
      headers: {
        "Content-Type": 'application/json',
        "Authorization": 'Bearer $token'
      },
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      final data = {
        'payload': {
          "staffID": globalDriver.getStaffID,
          "staffName": globalDriver.getFullName,
          "icNo": iCNumber, //113279928|022878977
          "mobileNo": globalDriver.getMobile,
          "staffRole": globalDriver.getStaffRole,
          "licNumber": licNumber,
          "employeeCode": globalDriver.getEmployeeCode,
          "extLicNumber": globalDriver.getExtLicNumber,
          "staffNote": globalDriver.getStaffNote,
          "emergencyContactInfo": globalDriver.getEmergencyContactInfo,
          "dateofBirth": globalDriver.getDateofBirth,
          "dateofJoin": globalDriver.getDateofJoin,
          "staffStatus": globalDriver.getStaffStatus,
          "dateOfResign": globalDriver.getDateOfResign,
          "resignNote": globalDriver.getResignNote,
          "englishLevel": globalDriver.getEnglishLevel,
          "createDate": globalDriver.getCreateDate,
          "createUser": globalDriver.getCreateUser,
          "updateDate": globalDriver.getUpdateDate,
          "updateUser": globalDriver.getUpdateUser, //Người update
          "licenseClass": globalDriver.getLicenseClass,
          "createName": globalDriver.getCreateName,
          "upDateName": globalDriver.getUpDateName, //Tên người update
          "avatarThumbnail": globalDriver.getAvatarThumbnail,
          "licenseExpDate": globalDriver.getLicenseExpDate,
          "icNoIssueDate": globalDriver.getIcNoIssueDate,
          "icNoIssuePlace": globalDriver.getIcNoIssuePlace,
          "licenseIssueDate": globalDriver.getLicenseIssueDate,
          "fleet_Desc": globalDriver.getFleetDesc,
          "foreignLanguage": globalDriver.getForeignLanguage
        }
      };
      getStaff();
      return DriverModel.fromJson(data);
    } else {}
    return update(iCNumber, licNumber);
  }

  @override
  Future deleteAcc() async {
    String token = globalUser.getToken;
    var body = {
      "UserId": globalUser.getIdUserName,
      "EmployeeId": globalUser.getId,
    };
    final response = await http.post(
      Uri.parse(ConfigServer.configSSO + UrlAPI.deleteAcc),
      body: jsonEncode(body),
      headers: {
        "Content-Type": 'application/json',
        "Authorization": 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      print("Delete Account Done");
    } else {
      print("Delete account fails");
    }
    return response;
  }
}
