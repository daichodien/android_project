import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fmbp/presentation/screens/auth/register/register_form.dart';

import '../../../controller/export_controller.dart';

class RegisterScreen extends StatefulWidget {
  static String routeName = "/register_screen";

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final LoginController _loginController = LoginController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("register".tr()),
      ),
      body: FormRegister(
        _loginController,
      ),
    );
  }
}
