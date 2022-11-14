// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:fmbp/data/sources/address.dart';
import 'package:fmbp/data/sources/api/url.dart';
import 'package:fmbp/data/sources/https/https.dart';
import 'package:fmbp/presentation/screens/home/index.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:location/location.dart';

import '../../../models/export_model.dart';
import '../../global/export_global.dart';

abstract class ILoginRepository {
  Future<LoginModel> getToken(String username, String password);
  Future<Response> getEmployee();
  Future<Response> getMenu();
  
  Future<Response> registerAcc(
    String employeeName,
    String loginName,
    String password,
    String firstName,
    String lastName,
    String email,
    String mobile,
  );
}

class LoginRepository extends ILoginRepository {
  @override
  Future<LoginModel> getToken(String username, String password) async {
    http.Response respone;
    var url = UrlAPI.token;
    respone = await http.post(
      Uri.parse(ConfigServer.configSSO + url),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: {
        "username": username,
        "password": password,
        "grant_type": "password",
        "client_id": "MB_ENT",
      },
    );
    if (respone.statusCode == 200) {
      var jsonBodyToken = jsonDecode(respone.body);
      globalUser.setToken = jsonBodyToken["access_token"];
      var employeeId = jsonBodyToken["as:employee_id"];
      var systemid = jsonBodyToken["as:system_id"];
      var userName = jsonBodyToken["userName"];

      globalUser.setId = int.parse(employeeId);
      globalUser.setSystemId = systemid;
      globalUser.setIdUserName = userName;

      return LoginModel.fromJson(jsonBodyToken);
    }

    return LoginModel();
  }

  @override
  Future<Response> getEmployee() async {
    Map map = {};
    map["EmployeeId"] = globalUser.getId;
    map["SystemId"] = globalUser.getSystemId;
    var response = await httpPostSSO(UrlAPI.employeePrivate.toString(), map);
    if (response.statusCode == 200) {
      print("done");
      var jsonResult = jsonDecode(response.body);

      // var deptDesc = jsonResult["payload"]["userDetail"]["deptDesc"];
      final staff = jsonResult["payload"]["staffInfo"];
      if (staff != null) {
        globalUser.setStaffID = jsonResult["payload"]["staffInfo"]["staffID"];
      } else {
        globalUser.setStaffID = null;
      }
      //Kiểm tra xem user có phải là tài xế không
      UserInfoPwdJsonResult userIdPwdJsonResult;
      userIdPwdJsonResult = UserInfoPwdJsonResult.fromJson(jsonResult);

      var subsidiaryId = userIdPwdJsonResult.userInfo?.subsidiaryId;
      globalUser.setSubsidiaryId = subsidiaryId;
      print(subsidiaryId);
      globalUser.setUsername =
          jsonResult["payload"]["userDetail"]["employeeName"];

      globalDriver.setFullName =
          jsonResult["payload"]["userDetail"]["employeeName"];
      globalDriver.setMobile = jsonResult["payload"]["userDetail"]["mobile"];
    }
    return response;
  }

  @override
  Future<Response> getMenu() async {
    Map map = {};
    map["UserID"] = globalUser.getIdUserName;
    map["SystemId"] = globalUser.getSystemId;
    map["PlatformId"] = 'MB_ENT'; //MB_MPI Đổi lại nếu serverDev
    map["SubsidiaryId"] = globalUser.getSubsidiaryId;
    var menuResponse = await httpPostSSO(UrlAPI.menu, map);
    if (menuResponse.statusCode == 200) {
      // var json = jsonDecode(response.body);1
      var pageMenuJson = json.decode(menuResponse.body);
      var menuChildJson =
          pageMenuJson["payload"].cast<Map<String, dynamic>>() as List;
      var menus = <PageMenuPermission>[];
      if (menuChildJson.isNotEmpty) {
        menus = menuChildJson
            .map<PageMenuPermission>(
                (jsonItem) => PageMenuPermission.fromJson(jsonItem))
            .toList();
      }
      pages.clear();
      pages.addAll(menus);
    } else {}
    return menuResponse;
  }

  @override
  Future<Response> registerAcc(
    String employeeName,
    String loginName,
    String password,
    String firstName,
    String lastName,
    String email,
    String mobile,
  ) async {
    Map map = {};
    map["EmployeeName"] = employeeName;
    map["LoginName"] = loginName;
    map["Password"] = password;
    map["FirstName"] = firstName;
    map["LastName"] = lastName;
    map["Email"] = email;
    map["Mobile"] = mobile;
    map["Address"] = "";
    map["Language"] = "EN";
    map["Gender"] = "M";

    var url = UrlAPI.registerAcc;
    var token = globalUser.getToken;
    final result = await http.post(
        Uri.parse(
          ConfigServer.configSSO + url,
        ),
        body: jsonEncode(map),
        headers: {
          "Content-Type": 'application/json',
          "Authorization": 'Bearer $token'
        }).timeout(const Duration(seconds: 10));
    if (result.statusCode == 200) {
      print("Register Done");
    } else {
      print("Register Fail");
    }

    return result;
  }

  
}
