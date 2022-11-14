class ListInpection {
  int? clId;
  int? checkDate;
  String? shipmentNo;
  String? equipmentCode;
  String? driverId;
  String? driverName;
  int? createDate;
  String? createUser;
  String? createUserName;
  double? totalScore;
  String? finalResult;
  String? isApproval;
  String? approveUser;
  String? approveDate;
  String? linksWeb;
  double? totalAllocatedScore;
  double? scorePercent;
  String? approveUserName;
  String? fleetModelDesc;
  String? codeDesc;
  String? checkType;

  ListInpection({
    this.clId,
    this.checkDate,
    this.shipmentNo,
    this.equipmentCode,
    this.driverId,
    this.driverName,
    this.createDate,
    this.createUser,
    this.createUserName,
    this.totalScore,
    this.finalResult,
    this.isApproval,
    this.approveUser,
    this.approveDate,
    this.linksWeb,
    this.totalAllocatedScore,
    this.scorePercent,
    this.approveUserName,
    this.fleetModelDesc,
    this.codeDesc,
    this.checkType,
  });

  factory ListInpection.fromJson(Map<String, dynamic> json) {
    return ListInpection(
      clId: json["clId"],
      checkDate: json["checkDate"],
      shipmentNo: json["shipmentNo"],
      equipmentCode: json["equipmentCode"],
      driverId: json["driverId"],
      driverName: json["driverName"],
      createDate: json["createDate"],
      createUser: json["createUser"],
      createUserName: json["createUserName"],
      totalScore: json["totalScore"],
      finalResult: json["finalResult"],
      isApproval: json["isApproval"],
      approveUser: json["approveUser"],
      approveDate: json["approveDate"],
      linksWeb: json["linksWeb"],
      totalAllocatedScore: json["totalAllocatedScore"],
      scorePercent: json["scorePercent"],
      approveUserName: json["approveUserName"],
      fleetModelDesc: json["fleetModelDesc"],
      codeDesc: json["codeDesc"],
      checkType: json["checkType"],
    );
  }
}
