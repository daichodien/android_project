// ignore_for_file: avoid_print

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fmbp/models/export_model.dart';
import 'package:fmbp/presentation/common/export_common.dart';
import 'package:fmbp/presentation/screens/home/index.dart';

import '../../../../widget/export_widget.dart';
import '../../../activity/index.dart';
import '../../../inspection/checklist/index.dart';
import '../../../inspection/checklist_QC/index.dart';
import '../../../inspection/checklist_technical/index.dart';
import '../../../profile/index.dart';
import '../../../todo_list/index.dart';
import 'drawer_service.dart';
import 'get_image.dart';

class ListItemMenu extends StatefulWidget {
  const ListItemMenu({Key? key}) : super(key: key);

  @override
  State<ListItemMenu> createState() => _ListItemMenuState();
}

class _ListItemMenuState extends State<ListItemMenu> {
  List<ListGroupMenuPermission> listGroupMenuPermission = [];
  List<PageMenuPermission> values = pages;
  List<Column> _listOfGroup = [];
  @override
  void initState() {
    getDrawer();
    super.initState();
  }

  void getDrawer() {
    values = pages;
    listGroupMenuPermission = [];
    for (var i = 0; i < values.length; i++) {
      listGroupMenuPermission.add(ListGroupMenuPermission(values[i]));
      print(listGroupMenuPermission[i].menu.menuName);
    }
    _listOfGroup = List<Column>.generate(
        listGroupMenuPermission.length,
        (index) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleMenu(index),
                listMenuItem(index),
              ],
            ));
  }

  Widget listMenuItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Container(
          decoration: const BoxDecoration(
              color: itemDrawerColor,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            // children: listGroupMenuPermission[index].menu.menuChilds.map((data) => Container(child: data,)).toList(),
            children: listGroupMenuPermission[index]
                .menu
                .menuChilds!
                .map((data) => ListTile(
                      title: Text(
                        data.menuName!.tr().toString(),
                        style: const TextStyle(
                          fontSize: 15,
                          color: textDarkBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      leading: getImage(data.component.toString()),
                      trailing: const IconCustom(
                          iConURL: "assets/icon/arrow_right.png", size: 20),
                      onTap: () async {
                        if (data.menuId == "MB001") {
                          Navigator.pushNamed(context, ProfileScreen.routeName);
                        }
                        if (data.menuId == "MB002") {
                          Navigator.pushNamed(
                              context, ActivityScreen.routeName);
                        }
                        if (data.menuId == "MB003") {
                          Navigator.pushNamed(
                              context, ToDoListScreen.routeName);
                        }
                        if (data.menuId == "MB004") {
                          Navigator.pushNamed(
                              context, CheckListScreen.routeName);
                        }
                        if (data.menuId == "MB005") {
                          print("QC");
                          // getCheckList(TypeCheck.QC.toString());
                          Navigator.pushNamed(
                              context, CheckListQCScreen.routeName);
                        }
                        if (data.menuId == "MB006") {
                          print("Tech");
                          // getCheckList(TypeCheck.Technical.toString());
                          Navigator.pushNamed(
                              context, CheckListTechnicalScreen.routeName);
                        }
                      },
                    ))
                .toList(),
          )),
    );
  }

  Widget titleMenu(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        textMenuName(
            listGroupMenuPermission[index].menu.menuName!.tr().toString()),
        style: const TextStyle(
          color: textDarkBlue,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: _listOfGroup
            .map((e) => Container(
                  child: e,
                ))
            .toList());
  }
}
