import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fmbp/data/global/export_global.dart';
import 'package:fmbp/presentation/export_presentation.dart';
import 'package:fmbp/presentation/screens/home/announcements/index.dart';
import 'package:fmbp/presentation/screens/navigations/menu/index.dart';

class BodyHome extends StatefulWidget {
  const BodyHome({Key? key}) : super(key: key);

  @override
  State<BodyHome> createState() => _BodyHomeState();
}

class _BodyHomeState extends State<BodyHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const Menu(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header(),
          const AnnouncementsBox(),
        ],
      ),
    );
  }

  Widget header() {
    return SizedBox(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/box_header.png"),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(45),
              bottomRight: Radius.circular(45)),
        ),
        child: Column(
          children: [
            topHeader(),
            bodyHeader(),
            const HeightSpacer(height: 0.02),
          ],
        ),
      ),
    );
  }

  Widget topHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                // Dùng để mở menu trái
                _scaffoldKey.currentState?.openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: textWhite,
              )),
        ],
      ),
    );
  }

  Widget bodyHeader() {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(
              flex: 2,
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/avt.png"),
                backgroundColor: bgDrawerColor,
                maxRadius: 60,
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  // NameDriver(),
                  Text(
                    globalDriver.getFullName.toString(),
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.06,
                      color: textDarkBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  globalUser.getStaffID != 0
                      ? Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          color: bgDrawerColor,
                          child: Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.02),
                            child: globalDriver.getFleetDesc == null
                                ? Text(
                                    "no_data".tr(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: textDarkBlue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : Text(
                                    globalDriver.getFleetDesc.toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: textDarkBlue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
