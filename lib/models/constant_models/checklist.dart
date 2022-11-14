class CheckListDetail {
  int? clId;
  String? equipmentCode;
  String? driverId;
  String? shipmentNo;
  String? result;
  String? comment;
  double? inspectionValue;
  double? score;
  int? qtId;
  String? inspectionItem;
  String? groupDesc;
  int? seqNo;

  CheckListDetail({
    this.clId,
    this.equipmentCode,
    this.driverId,
    this.shipmentNo,
    this.result,
    this.comment,
    this.inspectionValue,
    this.score,
    this.qtId,
    this.inspectionItem,
    this.groupDesc,
    this.seqNo,
  });

  // factory PageMenuPermission.fromJson(Map<String, dynamic> json) {
  //   var _menuChilds = <MenuChild>[];
  //   var menuChildJson = json["menuChils"].cast<Map<String, dynamic>>() as List;
  //   if (menuChildJson.length > 0) {
  //     _menuChilds = menuChildJson
  //         .map<MenuChild>((jsonItem) => MenuChild.fromJson(jsonItem))
  //         .toList();
  //   }

  factory CheckListDetail.fromJson(Map<String, dynamic> json) {
    return CheckListDetail(
      equipmentCode: json["equipmentCode"],
      driverId: json["driverId"],
      shipmentNo: json["shipmentNo"],
      result: json["result"],
      comment: json["comment"],
      inspectionValue: json["inspectionValue"],
      score: json["score"],
      clId: json["clId"],
      qtId: json["qtId"],
      inspectionItem: json["inspectionItem"],
      groupDesc: json["groupDesc"],
      seqNo: json["seqNo"],
    );
  }
}
