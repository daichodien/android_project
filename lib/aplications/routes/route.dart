import 'package:flutter/material.dart';
import 'package:fmbp/presentation/screens/activity/index.dart';
import 'package:fmbp/presentation/screens/auth/login/index.dart';
import 'package:fmbp/presentation/screens/auth/register/index.dart';
import 'package:fmbp/presentation/screens/home/index.dart';
import 'package:fmbp/presentation/screens/inbox/index.dart';
import 'package:fmbp/presentation/screens/inspection/checklist/index.dart';
import 'package:fmbp/presentation/screens/inspection/checklist_QC/index.dart';
import 'package:fmbp/presentation/screens/inspection/checklist_technical/index.dart';
import 'package:fmbp/presentation/screens/inspection/checklist_todo/index.dart';

import 'package:fmbp/presentation/screens/main/main_screen.dart';
import 'package:fmbp/presentation/screens/profile/helps/index.dart';
import 'package:fmbp/presentation/screens/profile/index.dart';
import 'package:fmbp/presentation/screens/profile/my_account/index.dart';
import 'package:fmbp/presentation/screens/profile/setting/setting.dart';
import 'package:fmbp/presentation/screens/todo_list/index.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => const LoginScreen(),
  RegisterScreen.routeName: (context) => const RegisterScreen(),
  MainScreen.routeName: (context) => const MainScreen(),

  HomeScreen.routeName: (context) => const HomeScreen(),
  ActivityScreen.routeName: (context) => const ActivityScreen(),
  InboxScreen.routeName: (context) => const InboxScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
//profile
  AccountScreen.routeName: (context) => const AccountScreen(),
  SettingScreen.routeName: (context) => const SettingScreen(),
  HelpScreen.routeName: (context) => const HelpScreen(),

  ToDoListScreen.routeName: (context) => const ToDoListScreen(),
  CheckListScreen.routeName: (context) => const CheckListScreen(),
  CheckListQCScreen.routeName: (context) => const CheckListQCScreen(),
  CheckListTechnicalScreen.routeName: (context) =>
      const CheckListTechnicalScreen(),
  CheckListWithTodoScreen.routeName: (context) =>
      const CheckListWithTodoScreen(),
};
