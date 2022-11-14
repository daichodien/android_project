class GlobalInspection {
  String? fromDate;
  String? toDate;
  String? type;
  String? bookNo;

  String? get getBookNo => bookNo;
  set setBookNo(String? value) => bookNo = value;

  String? get getFromDate => fromDate;
  set setFromDate(String? value) => fromDate = value;

  get getToDate => toDate;
  set setToDate(value) => toDate = value;

  get getType => type;
  set setType(value) => type = value;
}

GlobalInspection globalInspection = GlobalInspection();
