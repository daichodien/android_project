import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fmbp/presentation/screens/inspection/checklist_todo/body.dart';

class CheckListWithTodoScreen extends StatefulWidget {
  const CheckListWithTodoScreen({Key? key}) : super(key: key);
  static String routeName = "checklist_todo_screen";

  @override
  State<CheckListWithTodoScreen> createState() =>
      _CheckListWithTodoScreenState();
}

class _CheckListWithTodoScreenState extends State<CheckListWithTodoScreen> {
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
      body: const BodyCheckTodo(),
    );
  }
}
