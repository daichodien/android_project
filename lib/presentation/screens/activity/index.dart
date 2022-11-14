import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fmbp/presentation/screens/activity/body.dart';

import '../../controller/export_controller.dart';
import '../main/main_screen.dart';

class ActivityScreen extends StatefulWidget {
  static String routeName = "activity_screen";

  const ActivityScreen({Key? key}) : super(key: key);

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final TripController _tripController = TripController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("daily_trip_record".tr().toUpperCase()),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, MainScreen.routeName);
          },
          icon: Image.asset(
            "assets/icon/arrow_left.png",
            color: Colors.white,
            width: 30,
          ),
        ),
      ),
      // body: const Calendar(),
      body: BodyTripRecord(_tripController),
    );
  }
}
