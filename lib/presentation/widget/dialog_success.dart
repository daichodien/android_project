import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fmbp/presentation/common/colors.dart';
import 'package:fmbp/presentation/widget/icon_custom.dart';

class SuccessFull extends StatelessWidget {
  const SuccessFull({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          const Positioned(
            top: -30,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: defaultColor,
              child:
                  IconCustom(iConURL: "assets/icon/tick_white.png", size: 50),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.28,
            child: Center(
              child: Text(
                text.tr(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: textDarkBlue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
