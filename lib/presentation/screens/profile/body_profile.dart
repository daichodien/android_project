// ignore_for_file: avoid_print

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fmbp/data/global/export_global.dart';
import 'package:fmbp/presentation/export_presentation.dart';
import 'package:fmbp/presentation/screens/main/main_screen.dart';
import 'package:fmbp/presentation/screens/profile/components/avt.dart';
import 'package:fmbp/presentation/screens/profile/my_account/index.dart';

import '../auth/login/index.dart';
import 'components/item_profile.dart';
import 'helps/index.dart';
import 'setting/setting.dart';

class BodyProfile extends StatefulWidget {
  final InboxController _inboxController;
  final ProfileController _profileController;
  const BodyProfile(
    this._inboxController,
    this._profileController, {
    Key? key,
  }) : super(key: key);

  @override
  State<BodyProfile> createState() => _BodyProfileState();
}

class _BodyProfileState extends State<BodyProfile> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      children: [
        Column(
          children: [
            const HeightSpacer(height: 0.02),
            const Avt(),
            const HeightSpacer(height: 0.02),
            ItemProfile(
              icon: "assets/icon/avt.png",
              text: "my_account".tr(),
              press: () async {
                Navigator.pushNamed(context, AccountScreen.routeName);
              },
            ),
            // ItemProfile(
            //   icon: "assets/icon/notification.png",
            //   text: "notifications".tr(),
            //   press: () {
            //     print("Notification");
            //   },
            // ),
            ItemProfile(
              icon: "assets/icon/setting.png",
              text: "setting".tr(),
              press: () {
                print("setting");
                Navigator.pushNamed(context, SettingScreen.routeName);
              },
            ),
            ItemProfile(
              icon: "assets/icon/help.png",
              text: "help".tr(),
              press: () {
                print("Help");
                Navigator.pushNamed(context, HelpScreen.routeName);
              },
            ),
            // ItemProfile(
            //   icon: "assets/icon/delete_acc.png",
            //   text: "delete_acc".tr(),
            //   press: () {
            //     showDialog(
            //       context: context,
            //       barrierDismissible: false,
            //       builder: (context) => AreYouSure(
            //         text: "are_u_delete",
            //         pressOK: () {
            //           Navigator.pop(context, true);
            //         },
            //         pressCanel: () {
            //           Navigator.pop(context, false);
            //         },
            //       ),
            //     ).then((exit) async {
            //       if (exit == null) return;
            //       if (exit) {
            //         // widget._profileController.deleteAccount();
            //         widget._profileController
            //             .deleteAccount()
            //             .whenComplete(() => showDialog(
            //                   context: context,
            //                   builder: (context) =>
            //                       const SuccessFull(text: "delete_success"),
            //                 ))
            //             .whenComplete(() => Navigator.pushNamed(
            //                 context, LoginScreen.routeName));
            //       } else {}
            //       return;
            //     });
            //     print("delete acc");
            //   },
            // ),
            ItemProfile(
              icon: "assets/icon/log_out.png",
              text: "log_out".tr(),
              press: () {
                setState(() {
                  counter.value = widget._inboxController.getCountInbox();
                });
                Navigator.pushNamed(context, LoginScreen.routeName);
              },
            ),
          ],
        ),
      ],
    ));
  }
}
