import 'package:flutter/material.dart';

class IconCustom extends StatelessWidget {
  const IconCustom({
    Key? key,
    required this.iConURL,
    required this.size,
  }) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final iConURL;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      iConURL,
      width: size,
      height: size,
    );
  }
}
