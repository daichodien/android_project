import 'dart:convert';

class LoginModel {
  String? accessToken;
  String? userName;
  String? asEmployeeId;
  String? asSystemId;
  bool? loginStatus;

  LoginModel({
    this.accessToken,
    this.userName,
    this.asEmployeeId,
    this.asSystemId,
    this.loginStatus,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      accessToken: json["access_token"],
      userName: json["userName"],
      asEmployeeId: json["as:employee_id"],
      asSystemId: json["as:system_id"],
    );
  }

  // LoginModel copyWith({
  //   String? accessToken,
  //   String? userName,
  //   String? asEmployeeId,
  //   String? asSystemId,
  //   bool? loginStatus,
  // }) {
  //   return LoginModel(
  //     accessToken: accessToken,
  //     userName: userName,
  //     asEmployeeId: asEmployeeId,
  //     asSystemId: asSystemId,
  //     loginStatus: loginStatus,
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return {
  //     "access_token": accessToken,
  //     "userName": userName,
  //     "as:employee_id": asEmployeeId,
  //     "as:system_id": asSystemId,
  //   };
  // }

  // factory LoginModel.fromMap(Map<String, dynamic> map) {
  //   return LoginModel(
  //     accessToken: map["access_token"],
  //     userName: map["userName"],
  //     asEmployeeId: map["as:employee_id"],
  //     asSystemId: map["as:system_id"],
  //   );
  // }

  // String toJson() => jsonEncode(toMap());

  // factory LoginModel.fromJson(String source) =>
  //     LoginModel.fromMap(jsonDecode(source));
  @override
  String toString() {
    return '\n===================\n\nAccecsToken: $accessToken \nUserName: $userName\n===================';
  }

  //   @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;

  //   return other is HomePageModel &&
  //       other.name == name &&
  //       other.job == job &&
  //       other.id == id &&
  //       other.createdAt == createdAt;
  // }

  // @override
  // int get hashCode {
  //   return name.hashCode ^ job.hashCode ^ id.hashCode ^ createdAt.hashCode;
  // }
}
