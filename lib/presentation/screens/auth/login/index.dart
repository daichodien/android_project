import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:fmbp/presentation/export_presentation.dart';
import 'package:fmbp/presentation/screens/auth/register/index.dart';

import 'login_form.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "/login_screen";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController _loginController = LoginController();
  final ProfileController _profileController = ProfileController();
  final InboxController _inboxController = InboxController();
  // final ErrController _errController = ErrController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.fill,
          )),
          child: Column(
            children: [
              Expanded(
                  flex: 0,
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3)),
              Expanded(
                  flex: 0,
                  child: Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.02),
                    child: FormLogin(
                      _loginController,
                      _profileController,
                      _inboxController,
                    ),
                  )),
              Expanded(
                flex: -1,
                child: Container(),
                // TextButton(
                //     onPressed: () {
                //       Navigator.pushNamed(context, RegisterScreen.routeName);
                //     },
                //     child: Text(
                //       "register".tr(),
                //       style: const TextStyle(
                //         color: textWhite,
                //         fontSize: sizeTextDefault,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
