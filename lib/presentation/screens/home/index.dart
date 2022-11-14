import 'package:flutter/material.dart';
import 'package:fmbp/models/export_model.dart';
import 'package:fmbp/presentation/screens/home/body.dart';

// final pages = <PageMenuPermission>[];
final pages = <PageMenuPermission>[];

class HomeScreen extends StatelessWidget {
  static String routeName = "/home_screen";

  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BodyHome(),
    );
  }
}
