import 'package:flutter/material.dart';

class PaddingColum extends StatelessWidget {
  const PaddingColum({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: MediaQuery.of(context).size.width * 0.01);
  }
}
