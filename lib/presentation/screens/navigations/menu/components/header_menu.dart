import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fmbp/data/global/export_global.dart';
import 'package:fmbp/presentation/common/export_common.dart';
import 'package:fmbp/presentation/export_presentation.dart';

class HeaderMenu extends StatelessWidget {
  const HeaderMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/layout_bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05)),
            const CircleAvatar(
              backgroundImage: AssetImage("assets/images/avt.png"),
              backgroundColor: defaultColor,
              maxRadius: 50,
            ),
            const HeightSpacer(height: 0.01),
            Text(
              "Feet Management and Booking".tr(),
              style: const TextStyle(
                color: defaultColor,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const HeightSpacer(height: 0.01),
            Text(
              globalDriver.getFullName.toString(),
              style: const TextStyle(
                color: textDarkBlue,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const HeightSpacer(height: 0.02),
          ],
        ),
      ),
    );
  }
}
