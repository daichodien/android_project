class GlobalUser {
  String? _token;
  String? _employeeId;
  String? _systemId;
  String? username;
  int? id;
  int? staffID;
  String? idUserName;
  String? subsidiaryId;

  String? get getSubsidiaryId => subsidiaryId;
  set setSubsidiaryId(String? value) => subsidiaryId = value;

  String? get getIdUserName => idUserName;
  set setIdUserName(String? value) => idUserName = value;

  int? get getStaffID => staffID;
  set setStaffID(int? value) => staffID = value;

  int? get getId => id;
  set setId(int? value) => id = value;

  String? get getUsername => username;
  set setUsername(String? username) => username = username;

  String? get getSystemId => _systemId;
  set setSystemId(String? value) => _systemId = value;

  String? get getEmployeeId => _employeeId;
  set setEmployeeId(String? value) => _employeeId = value;

  get getToken => _token;
  set setToken(value) => _token = value;
}

GlobalUser globalUser = GlobalUser();
