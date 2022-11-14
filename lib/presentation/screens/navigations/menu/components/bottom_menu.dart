import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../common/export_common.dart';

var version = "1.0.2";

class BottomMenu extends StatelessWidget {
  const BottomMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   ConfigServer.configSSO == ServerDEV.SSO
          //       ? "Server DEV"
          //       : "Server PRO",
          //   style: const TextStyle(
          //     fontStyle: FontStyle.italic,
          //     color: textRed,
          //   ),
          // ),
          Text(
            "${"All right reserved 2022 - MP Logistics".tr()} ${version}",
            style: styleBottom(),
          ),
        ],
      ),
    );
  }

  TextStyle styleBottom() {
    return const TextStyle(
      fontStyle: FontStyle.italic,
      color: defaultColor,
    );
  }
}
