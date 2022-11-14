import 'package:flutter/material.dart';
import 'package:fmbp/presentation/common/export_common.dart';

class TextTitle extends StatelessWidget {
  const TextTitle({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: styleDefaultText,
    );
  }
}
