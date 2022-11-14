// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fmbp/presentation/controller/export_controller.dart';
import 'package:fmbp/presentation/screens/inbox/body.dart';
// import 'package:fmbp/presentation/screens/inbox/inbox_body.dart';

class InboxScreen extends StatefulWidget {
  static String routeName = "inbox_screen";
  const InboxScreen({Key? key}) : super(key: key);

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final InboxController _inboxController = InboxController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("inbox".tr().toUpperCase()),
        automaticallyImplyLeading: false,
      ),
      body: ListNotifications(_inboxController),
    );
  }
}
