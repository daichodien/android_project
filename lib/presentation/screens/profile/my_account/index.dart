import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../controller/export_controller.dart';
import 'account_form.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);
  static String routeName = "account_screen";

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final ProfileController _profileController = ProfileController();

  @override
  void initState() {
    _profileController.getStaff();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: Text("my_account".tr()),
      ),
      // body: const BodyMyAccount(),
      body: FormAccount(_profileController),
    );
  }
}
