class ToDoList {
  String? bookNo;
  int? bookDate;
  String? pickUpPlace;
  int? pickupTime;
  String? returnPlace;
  int? returnTime;
  String? bookStatus;
  String? assignedFleet;
  String? staffName;
  int? brId;
  int? bookAccept;
  int? fleetId;
  int? isPickUp;
  String? customerName;
  String? mobileNo;
  String? pickUpPlaceDetail;
  String? returnPlaceDetail;

  ToDoList({
    this.bookNo,
    this.bookDate,
    this.pickUpPlace,
    this.pickupTime,
    this.returnPlace,
    this.returnTime,
    this.bookStatus,
    this.assignedFleet,
    this.staffName,
    this.brId,
    this.bookAccept,
    this.fleetId,
    this.isPickUp,
    this.customerName,
    this.mobileNo,
    this.pickUpPlaceDetail,
    this.returnPlaceDetail,
  });
  factory ToDoList.fromJson(Map<String, dynamic> json) {
    return ToDoList(
      bookNo: json['bookNo'],
      bookDate: json['bookDate'],
      pickUpPlace: json['pickUpPlace'],
      pickupTime: json['pickupTime'],
      returnPlace: json['returnPlace'],
      returnTime: json['returnTime'],
      bookStatus: json['bookStatus'],
      assignedFleet: json['assignedFleet'],
      staffName: json['staffName'],
      brId: json['brId'],
      bookAccept: json['bookAccept'],
      fleetId: json['fleetId'],
      isPickUp: json['isPickUp'],
      customerName: json['customerName'],
      mobileNo: json['mobileNo'],
      pickUpPlaceDetail: json['pickUpPlaceDetail'],
      returnPlaceDetail: json['returnPlaceDetail'],
    );
  }
}
