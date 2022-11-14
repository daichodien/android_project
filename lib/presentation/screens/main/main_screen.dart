import 'package:badges/badges.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fmbp/presentation/common/colors.dart';
import 'package:fmbp/presentation/controller/export_controller.dart';
import 'package:fmbp/presentation/screens/activity/index.dart';
import 'package:fmbp/presentation/screens/home/index.dart';
import 'package:fmbp/presentation/screens/inbox/body.dart';
import 'package:fmbp/presentation/screens/inbox/index.dart';
import 'package:fmbp/presentation/screens/profile/index.dart';
import 'package:fmbp/presentation/widget/export_widget.dart';

ValueNotifier<int> counter = ValueNotifier<int>(0);

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static String routeName = "main_screen";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectScreen = 0;
  final InboxController _inboxController = InboxController();
  int count = 0;
  @override
  void initState() {
    counter.value = _inboxController.getCountInbox();
    super.initState();
  }

  final GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();

  List<Widget> listScreen = [
    const HomeScreen(),
    const ActivityScreen(),
    const InboxScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: listScreen[selectScreen],
        bottomNavigationBar: CurvedNavigationBar(
          key: bottomNavigationKey,
          onTap: (value) {
            setState(() {
              selectScreen = value;
            });
          },
          items: [
            const IconCustom(
              iConURL: "assets/icon/navbar_home.png",
              size: 25,
            ),
            const IconCustom(iConURL: "assets/icon/activity.png", size: 25),
            ValueListenableBuilder<int>(
              valueListenable: counter,
              builder: (BuildContext context, int value, Widget? child) {
                return Badge(
                    position: const BadgePosition(
                      top: -20,
                      end: -15,
                    ),
                    badgeContent: Text(
                      value.toString(),
                      style: const TextStyle(
                        color: textWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const IconCustom(
                        iConURL: "assets/icon/chat.png", size: 25));
              },
            ),
            // Badge(
            //     position: const BadgePosition(
            //       top: -20,
            //       end: -15,
            //     ),
            //     badgeContent: Text(
            //       count.toString(),
            //       style: const TextStyle(
            //         color: textWhite,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //     child:
            //         const IconCustom(iConURL: "assets/icon/chat.png", size: 25)),
            const IconCustom(iConURL: "assets/icon/avt.png", size: 25),
          ],
          height: 60,
          color: bgDrawerColor,
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: bgDrawerColor,
        ),
      ),
    );
  }
}
