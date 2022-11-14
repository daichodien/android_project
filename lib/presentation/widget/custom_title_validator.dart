import 'package:flutter/material.dart';
import 'package:fmbp/presentation/common/export_common.dart';

import 'components/text_title.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({Key? key, this.text}) : super(key: key);
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextTitle(text: text.toString()),
        const Text(
          " *",
          style: styleTextError,
        )
      ],
    );
  }
}
