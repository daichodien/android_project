import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'body.dart';

class HelpScreen extends StatelessWidget {
  static String routeName = "helps_screen";
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("help".tr().toUpperCase()),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            "assets/icon/arrow_left.png",
            color: Colors.white,
            width: 30,
          ),
        ),
      ),
      // body: const BodyProfile(),
      body: const BodyHelp(),
    );
  }
}
