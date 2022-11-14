import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fmbp/presentation/common/colors.dart';
import 'package:fmbp/presentation/screens/navigations/menu/components/list_menu.dart';
import 'package:fmbp/presentation/widget/export_widget.dart';

import '../../../auth/login/index.dart';

class BodyMenu extends StatefulWidget {
  const BodyMenu({Key? key}) : super(key: key);

  @override
  State<BodyMenu> createState() => _BodyMenuState();
}

class _BodyMenuState extends State<BodyMenu> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const ListItemMenu(),
          btnLogout(),
        ],
      ),
    );
  }

  Widget btnLogout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Container(
        decoration: const BoxDecoration(
          color: textWhite,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: ListTile(
          onTap: () {
            // Navigator.pushNamed(context, LoginScreen.routeName);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
          leading: const IconCustom(
            iConURL: "assets/icon/log_out.png",
            size: 25,
          ),
          trailing: const IconCustom(
            iConURL: "assets/icon/arrow_right.png",
            size: 20,
          ),
          title: Text(
            "Log out".tr(),
            style: const TextStyle(
              color: textDarkBlue,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
