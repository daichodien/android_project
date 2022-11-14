import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingNoBox extends StatelessWidget {
  const LoadingNoBox({Key? key, required this.color}) : super(key: key);
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SpinKitCircle(
      color: color,
      size: 70.0,
    );
  }
}
