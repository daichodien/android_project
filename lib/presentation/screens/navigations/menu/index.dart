import 'package:flutter/material.dart';
import 'package:fmbp/presentation/common/export_common.dart';
import 'package:fmbp/presentation/screens/navigations/menu/components/body_menu.dart';
import 'package:fmbp/presentation/screens/navigations/menu/components/header_menu.dart';

import 'components/bottom_menu.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: bgDrawerColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Expanded(
              flex: 2,
              child: HeaderMenu(),
            ),
            Expanded(
              flex: 3,
              child: BodyMenu(),
            ),
            Expanded(
              flex: -1,
              child: BottomMenu(),
            ),
          ],
        ),
      ),
    );
  }
}
