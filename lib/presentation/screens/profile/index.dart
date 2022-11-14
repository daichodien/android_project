import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fmbp/presentation/controller/export_controller.dart';

import '../main/main_screen.dart';
import 'body_profile.dart';
// import 'package:fmbp/presentation/screens/mainPage/index.dart';

// import 'body_profile.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = "profile_screen";

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final InboxController _inboxController = InboxController();
  final ProfileController _profileController = ProfileController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("profile_user".tr().toUpperCase()),
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
      body: BodyProfile(_inboxController, _profileController),
    );
  }
}
