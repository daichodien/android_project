import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fmbp/presentation/common/export_common.dart';

import '../common/colors.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Color.fromARGB(162, 245, 244, 242),
        ),
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.width * 0.3,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              flex: 5,
              child: SpinKitCircle(
                color: defaultColor,
                size: 80.0,
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                "loading . . .".tr(),
                style: styleDefaultText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
