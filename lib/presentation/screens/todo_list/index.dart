import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fmbp/presentation/controller/export_controller.dart';
import 'package:fmbp/presentation/screens/main/main_screen.dart';
import 'package:fmbp/presentation/screens/todo_list/body.dart';

// final announcement = <Announcement>[];

class ToDoListScreen extends StatefulWidget {
  static String routeName = "todolist_screen";
  const ToDoListScreen({Key? key}) : super(key: key);

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  final TodoController _todoController = TodoController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("todo_list".tr().toUpperCase()),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, MainScreen.routeName);
          },
          icon: Image.asset(
            "assets/icon/arrow_left.png",
            color: Colors.white,
            width: 30,
          ),
        ),
      ),
      body: BodyToDo(_todoController),
      // body: const BodyTodo(),
    );
  }
}
