import 'package:flutter/material.dart';

import '../../../../widget/icon_custom.dart';

StatelessWidget getImage(String component) {
  switch (component) {
    case 'triprecords':
      return const IconCustom(iConURL: "assets/icon/trip_record.png", size: 25);
    case 'checklist':
      return const IconCustom(iConURL: "assets/icon/check_list.png", size: 25);
    case 'userprofile':
      return const IconCustom(iConURL: "assets/icon/avt.png", size: 25);
    case 'todolist':
      return const IconCustom(iConURL: "assets/icon/todo_list.png", size: 25);
    case 'checklist2':
      return const IconCustom(iConURL: "assets/icon/check_list.png", size: 25);
    case 'announcement':
      return const IconCustom(
          iConURL: "assets/icon/announcement.png", size: 25);
    default:
      return const IconCustom(
          iConURL: "assets/icon/announcement.png", size: 25);
  }
}
