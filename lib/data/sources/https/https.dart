import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../global/export_global.dart';
import '../address.dart';

Future<http.Response> httpPostSSO(String url, dynamic body) async {
  var token = globalUser.getToken;
  http.Response result;
  try {
    result = await http.post(
        Uri.parse(
          ConfigServer.configSSO + url,
        ),
        body: jsonEncode(body),
        headers: {
          "Content-Type": 'application/json',
          "Authorization": 'Bearer $token'
        }).timeout(const Duration(seconds: 10));
  } catch (e) {
    result = await http.post(
        Uri.parse(
          ConfigServer.configSSO + url,
        ),
        body: jsonEncode(body),
        headers: {
          "Content-Type": 'application/json',
          "Authorization": 'Bearer $token'
        }).timeout(const Duration(seconds: 10));
  }
  return result;
}
