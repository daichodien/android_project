class TripRecord {
  int? trId;
  String? fleetDesc;
  String? staffName;
  String? fleetModelDesc;
  int? lastestMile;
  int? lastRead;
  int? startTime;
  int? endTime;
  int? startMile;
  int? endMile;
  int? mileRun;
  String? routeMemo;
  int? tollFee;
  int? parkingFee;
  String? tripMemo;
  int? createDate;
  String? bookNo;
  String? approved;
  int? approvalDate;
  int? approveUser;
  String? isApprovel;
  int? endUserVerifyDate;
  String? overTime;
  String? customerName;
  String? lat;
  String? lon;

  TripRecord(
      {this.trId,
      this.fleetDesc,
      this.staffName,
      this.fleetModelDesc,
      this.lastestMile,
      this.lastRead,
      this.startTime,
      this.endTime,
      this.startMile,
      this.endMile,
      this.mileRun,
      this.routeMemo,
      this.tollFee,
      this.parkingFee,
      this.tripMemo,
      this.createDate,
      this.bookNo,
      this.approved,
      this.approvalDate,
      this.approveUser,
      this.isApprovel,
      this.endUserVerifyDate,
      this.overTime,
      this.customerName,
      this.lat,
      this.lon});
  factory TripRecord.fromJson(Map<String, dynamic> json) {
    return TripRecord(
      trId: json['trId'],
      fleetDesc: json['fleet_Desc'],
      staffName: json['staffName'],
      fleetModelDesc: json['fleetModelDesc'],
      lastestMile: json['lastestMile'],
      lastRead: json['lastRead'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      startMile: json['startMile'],
      endMile: json['endMile'],
      mileRun: json['mileRun'],
      routeMemo: json['routeMemo'],
      tollFee: json['tollFee'],
      parkingFee: json['parkingFee'],
      tripMemo: json['tripMemo'],
      createDate: json['createDate'],
      bookNo: json['bookNo'],
      approved: json['approved'],
      approvalDate: json['approvalDate'],
      approveUser: json['approveUser'],
      isApprovel: json['isApprovel'],
      endUserVerifyDate: json['endUserVerifyDate'],
      overTime: json['overTime'],
      customerName: json['customerName'],
      lat: json['lat'],
      lon: json['lon'],
    );
  }
}
