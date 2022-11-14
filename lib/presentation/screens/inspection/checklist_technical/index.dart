import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fmbp/presentation/controller/inspection/inspection_controller.dart';
import 'package:fmbp/presentation/screens/inspection/checklist/body.dart';
import 'package:fmbp/presentation/screens/inspection/checklist_technical/body.dart';
import 'package:fmbp/presentation/screens/inspection/list_inspection.dart';

import '../../../common/colors.dart';

class CheckListTechnicalScreen extends StatefulWidget {
  const CheckListTechnicalScreen({Key? key}) : super(key: key);
  static String routeName = "checklist_tech_screen";

  @override
  State<CheckListTechnicalScreen> createState() =>
      _CheckListTechnicalScreenState();
}

class _CheckListTechnicalScreenState extends State<CheckListTechnicalScreen> {
  final InspectionController _inspectionController = InspectionController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            "assets/icon/arrow_left.png",
            color: Colors.white,
            width: 30,
          ),
        ),
        title: Text("Check List".tr().toUpperCase()),
        automaticallyImplyLeading: false,
      ),
      body: ListInspection(_inspectionController),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: defaultColor,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => addCheckList(context),
        ),
        label: Text("add_check".tr()),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Scaffold addCheckList(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            "assets/icon/arrow_left.png",
            color: Colors.white,
            width: 30,
          ),
        ),
        title: Text("add_check".tr().toUpperCase()),
      ),
      body: const BodyCheckListTechnical(),
    );
  }
}
