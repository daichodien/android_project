import 'package:flutter/material.dart';

import '../common/colors.dart';

class CardCustom extends StatelessWidget {
  const CardCustom({Key? key, required this.widget}) : super(key: key);

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: bgDrawerColor,
      child: widget,
    );
  }
}
