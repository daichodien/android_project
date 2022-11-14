mixin UrlAPI {
  static const String token = "token";
  static const String employeePrivate = "api/userprofile/getemployeeprivate";
  static const String menu = "api/ssocommonservice/menus";
  static const String userProfile = "api/authentication/userprofile/";
  static const String getStaff = "api/etp/staff/getstaff/?id=";
  static const String updateStaff = "api/etp/staff/updatestaff";
  // + userID(employeeID)
  static const String getAnnouncements = "api/etp/announcement/getformobile/";
  static const String getTodoList = "api/etp/booking/gettodobooking";
  //url cho thong bao
  static const String getnotifications = "api/GetMessage/";
  static const String deleteNotifications = "api/DeleteMessage/";
  //trip
  static const String acceptTrip = "api/etp/booking/saveaccepttrip";
  static const String saveBookTrip = "api/etp/booking/savebooktriprecord";
  static const String saveFleetTracking =
      "api/etp/fleet/savefleettracking"; // click pickup
  static const String getTripRecord = "api/etp/support/gettriprecordsmobileapp";
  static const String getMile = "api/etp/fleet/getfleetmile";
  static const String addDayTrip = "api/etp/support/savedaytriprecord";
  static const String deleteTrip = "api/etp/support/deletetriprecord";
  static const String getListInpection =
      "api/etp/support/getchecklistinspection";
  static const String checklistDetails =
      "api/etp/support/getchecklistinspectiondetail";

  static const String registerAcc = "api/userprofile/registrationaccount";
  static const String deleteAcc = "api/userprofile/employee/deleteuser";
}
