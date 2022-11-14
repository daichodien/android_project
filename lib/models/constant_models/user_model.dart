// ignore_for_file: prefer_collection_literals, unnecessary_this, no_leading_underscores_for_local_identifiers
class UserInfoPwdJsonResult {
  UserInfo? userInfo;
  SystemInfor? systemInfor;
  UserInfoPwdJsonResult({this.userInfo, this.systemInfor});
  factory UserInfoPwdJsonResult.fromJson(Map<String, dynamic> jsondata) {
    var _userInfo = UserInfo();
    _userInfo = UserInfo.fromJson(jsondata);
    // var _staffInfo = new StaffInfo();
    // _staffInfo = StaffInfo.fromJson(jsondata);
    var _systemInfo = SystemInfor();
    _systemInfo = SystemInfor.fromJson(jsondata);

    return UserInfoPwdJsonResult(userInfo: _userInfo, systemInfor: _systemInfo);
  }
}

class UserInfo {
  String? subsidiaryId;
  String? subsidiaryName;
  String? employeeName;
  int? idIssueDate;
  String? nationality;
  String? nativePlace;
  String? lastEducationName;
  String? permanentAddress;
  String? mobile;

  UserInfo({
    this.subsidiaryId,
    this.subsidiaryName,
    this.employeeName,
    this.idIssueDate,
    this.nationality,
    this.nativePlace,
    this.mobile,
    this.lastEducationName,
    this.permanentAddress,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      subsidiaryId: json['payload']['userDetail']['subsidiaryId'],
      subsidiaryName: json['payload']['userDetail']['subsidiaryName'],
      employeeName: json['payload']['userDetail']['employeeName'],
      nationality: json['payload']['userDetail']['nationality'],
      nativePlace: json['payload']['userDetail']['nativePlace'],
      lastEducationName: json['payload']['userDetail']['lastEducationName'],
      permanentAddress: json['payload']['userDetail']['permanentAddress'],
      mobile: json['payload']['userDetail']['mobile'],
    );
  }
}

class StaffInfo {
  int? staffID;
  String? staffName;
  String? fleetDesc;

  StaffInfo({this.staffID, this.staffName, this.fleetDesc});

  factory StaffInfo.fromJson(Map<String, dynamic> json) {
    return StaffInfo(
      staffID: json['payload']['staffID'],
      staffName: json['payload']['staffName'],
      fleetDesc: json['payload']['fleet_Desc'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['staffID'] = this.staffID;
    data['staffName'] = this.staffName;
    data['fleet_Desc'] = this.fleetDesc;
    return data;
  }
}

class SystemInfor {
  String? systemId;
  String? systemName;
  String? notificationUrl;
  String? inspectionUrl;

  SystemInfor(
      {this.systemId,
      this.systemName,
      this.notificationUrl,
      this.inspectionUrl});

  factory SystemInfor.fromJson(Map<String, dynamic> json) {
    return SystemInfor(
      systemId: json['payload']['systemInfo']['systemId'],
      systemName: json['payload']['systemInfo']['systemName'],
      notificationUrl: json['payload']['systemInfo']['notificationUrl'],
      inspectionUrl: json['payload']['systemInfo']['inspectionUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['systemId'] = this.systemId;
    data['systemName'] = this.systemName;
    data['notificationUrl'] = this.notificationUrl;
    data['inspectionUrl'] = this.inspectionUrl;
    return data;
  }
}
