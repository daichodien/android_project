import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../widget/export_widget.dart';

class Camera extends StatelessWidget {
  const Camera({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => SuccessFull(text: "update".tr()));
        },
        iconSize: 50,
        icon: const IconCustom(iConURL: "assets/icon/camera.png", size: 50));
  }
}