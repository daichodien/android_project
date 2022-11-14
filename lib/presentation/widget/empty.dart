import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fmbp/presentation/common/colors.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/icon/empty.png",
            opacity: const AlwaysStoppedAnimation<double>(0.5),
            color: textGrey,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Text(
            text.tr().toUpperCase(),
            style: const TextStyle(
              fontSize: 15,
              color: Color.fromARGB(126, 100, 100, 100),
            ),
          )
        ],
      ),
    );
  }
}
