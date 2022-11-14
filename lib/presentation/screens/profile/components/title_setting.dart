import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../common/colors.dart';

class TitleSetting extends StatelessWidget {
  const TitleSetting({
    Key? key,
    required this.keyText,
  }) : super(key: key);
  final String keyText;
  @override
  Widget build(BuildContext context) {
    return Text(
      keyText.tr().toUpperCase(),
      style: const TextStyle(
        color: textBlack,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class Language {
  Locale locale;
  String langName;
  Language({
    required this.locale,
    required this.langName,
  });
}
