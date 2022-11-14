import 'package:fmbp/models/export_model.dart';
import 'package:http/http.dart';

import '../../../data/repository/export_repository.dart';

class LoginController {
  final LoginRepository _loginRepository = LoginRepository();
  final AnnouncementsRepository _announcementsRepository =
      AnnouncementsRepository();

  final TripRepository _tripRepository = TripRepository();
  // bool? loginStatus() {
  //   return _loginRepository.login;
  // }

  Future<LoginModel> gettToken(String username, String password) async {
    return _loginRepository.getToken(username, password);
  }

  Future<Response> getEmployeePrivate() {
    return _loginRepository.getEmployee();
  }

  Future<Response> getMenuPermisson() {
    return _loginRepository.getMenu();
  }

  Future getAnnouncements() {
    return _announcementsRepository.getAnn();
  }

  Future getMile() {
    return _tripRepository.getFleetMile();
  }

  Future<Response> register(
    String employeeName,
    String loginName,
    String password,
    String firstName,
    String lastName,
    String email,
    String mobile,
  ) {
    return _loginRepository.registerAcc(
        employeeName, loginName, password, firstName, lastName, email, mobile);
  }

  Future initLocation() {
    return _tripRepository.initLocationService();
  }
}
