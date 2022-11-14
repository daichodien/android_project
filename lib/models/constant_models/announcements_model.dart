class Announcement {
  int? annId;
  String? subject;
  String? contents;
  String? isUse;
  String? expireDate;
  int? createDate;
  int? createUser;
  String? createUserName;
  String? updateDate;
  int? updateUser;
  int? agreedUser;
  String? annType;
  String? annTypeDesc;
  int? isSign;
  String? agreedDate;
  String? requestforDriverAgreement;

  Announcement(
      {this.annId,
      this.annType,
      this.annTypeDesc,
      this.contents,
      this.createDate,
      this.createUser,
      this.createUserName,
      this.expireDate,
      this.isUse,
      this.subject,
      this.updateDate,
      this.updateUser,
      this.agreedUser,
      this.isSign,
      this.agreedDate,
      this.requestforDriverAgreement});
  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      annId: json["annId"],
      annType: json["annType"],
      annTypeDesc: json["annTypeDesc"],
      contents: json["contents"],
      subject: json["subject"],
      createDate: json["createDate"],
      // createDate: convertTime(json["createDate"]),
      // expireDate: convertTime(json["expireDate"]),
      // agreedDate: convertTime(json["agreedDate"]),
      createUserName: json["createUserName"],
      createUser: json["createUser"],
      agreedUser: json["agreedUser"],
      isSign: json["isSign"],
      requestforDriverAgreement: json["requestforDriverAgreement"],
    );
  }
}
