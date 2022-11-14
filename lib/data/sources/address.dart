import 'package:fmbp/data/sources/server/contant_servers.dart';

mixin ConfigServer {
  static String configSSO = ServerPROD.SSO;
  static String configAddress = ServerPROD.address;
  static String configNotification = ServerPROD.notification;
  static String configInspection = ServerPROD.inspection;
  static String configHub = ServerPROD.hub;
  static String configAPI = ServerPROD.API;
  // static String configCode = ServerDEV.Code;
}
// ServerDEV
// ServerPROD