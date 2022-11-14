class DriverModel {
  final String? staffName;
  final String? mobileNo;
  final String? icNo;
  final String? licNumber;
  final String? fleetDesc;

  final int? staffID;
  final String? staffRole;
  final String? employeeCode;
  final String? extLicNumber;
  final String? staffNote;
  //
  final String? emergencyContactInfo;
  final int? dateofBirth;
  final int? dateofJoin;
  final String? staffStatus;
  final String? dateOfResign;
  //
  final String? resignNote;
  final String? englishLevel;
  final int? createDate;
  final String? createUser;
  final int? updateDate;
  final String? updateUser;
  final String? licenseClass;
  final String? createName;
  final String? upDateName;
  final String? avatarThumbnail;
  final int? licenseExpDate;
  final int? icNoIssueDate;
  final String? icNoIssuePlace;
  final int? licenseIssueDate;
  final String? foreignLanguage;

  const DriverModel({
    this.staffName,
    this.mobileNo,
    this.icNo,
    this.licNumber,
    this.fleetDesc,
    //
    this.staffID,
    this.staffRole,
    this.employeeCode,
    this.extLicNumber,
    this.staffNote,
    // //
    this.emergencyContactInfo,
    this.dateofBirth,
    this.dateofJoin,
    this.staffStatus,
    this.dateOfResign,
    this.resignNote,
    this.englishLevel,
    this.createDate,
    this.createUser,
    this.updateDate,
    this.updateUser,
    this.licenseClass,
    this.createName,
    this.upDateName,
    this.avatarThumbnail,
    this.licenseExpDate,
    this.icNoIssueDate,
    this.icNoIssuePlace,
    this.licenseIssueDate,
    this.foreignLanguage,
  });
  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      staffName: json["payload"]["staffName"],
      mobileNo: json["payload"]["mobileNo"],
      icNo: json["payload"]["icNo"],
      licNumber: json["payload"]["licNumber"],
      fleetDesc: json["payload"]["fleet_Desc"],
      staffID: json["payload"]["staffID"],
      staffRole: json["payload"]["staffRole"],
      employeeCode: json["payload"]["employeeCode"],
      extLicNumber: json["payload"]["extLicNumber"],
      staffNote: json["payload"]["staffNote"],
      emergencyContactInfo: json["payload"]["emergencyContactInfo"],
      dateofBirth: json["payload"]["dateofBirth"],
      dateofJoin: json["payload"]["dateofJoin"],
      staffStatus: json["payload"]["staffStatus"],
      dateOfResign: json["payload"]["dateOfResign"],
      resignNote: json["payload"]["resignNote"],
      englishLevel: json["payload"]["englishLevel"],
      createDate: json["payload"]["createDate"],
      createUser: json["payload"]["createUser"],
      updateDate: json["payload"]["updateDate"],
      updateUser: json["payload"]["updateUser"],
      licenseClass: json["payload"]["licenseClass"],
      createName: json["payload"]["createName"],
      upDateName: json["payload"]["upDateName"],
      avatarThumbnail: json["payload"]["avatarThumbnail"],
      licenseExpDate: json["payload"]["licenseExpDate"],
      icNoIssueDate: json["payload"]["icNoIssueDate"],
      icNoIssuePlace: json["payload"]["icNoIssuePlace"],
      licenseIssueDate: json["payload"]["licenseIssueDate"],
      foreignLanguage: json["payload"]["foreignLanguage"],
    );
  }
}
