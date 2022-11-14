// ignore_for_file: unused_element, avoid_print, use_build_context_synchronously

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fmbp/presentation/export_presentation.dart';
import 'package:fmbp/presentation/screens/main/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormLogin extends StatefulWidget {
  final LoginController _loginController;
  final ProfileController _profileController;
  final InboxController _inboxController;
  const FormLogin(
      this._loginController, this._profileController, this._inboxController,
      {Key? key})
      : super(key: key);

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final List<String?> errors = [];
  String? password;
  TextEditingController passwordController = TextEditingController();
  String? userName;
  bool _obscureText = true;
  TextEditingController userNameController = TextEditingController();
  bool _isRemember = false;

  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    loadUserPassword();
    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  Widget buildPassword() {
    return TextFormField(
      obscureText: _obscureText,
      controller: passwordController,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: erInformation.tr());
          removeError(error: erNullPassword.tr());
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: erNullPassword.tr());
          removeError(error: erInformation.tr());
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "passWord".tr(),
        hintText: "Enter your password".tr(),
        labelStyle: styleLabelInput,
        hintStyle: styleHintInput,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          icon: Icon(
            _obscureText ? Icons.lock : Icons.lock_open,
            color: Colors.black45,
          ),
        ),
      ),
    );
  }

  Widget buildUserName() {
    return TextFormField(
      controller: userNameController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onSaved: (newValue) => userName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: erNullUserName.tr());
          removeError(error: erInformation.tr());
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: erNullUserName.tr());
          removeError(error: erInformation.tr());
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "userName".tr(),
        hintText: "Enter your user name".tr(),
        labelStyle: styleLabelInput,
        hintStyle: styleHintInput,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const Icon(
          Icons.person_outline,
          color: Colors.black45,
        ),
      ),
    );
  }

  void loadUserPassword() async {
    print("Load User");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var user = prefs.getString("user") ?? "";
      var password = prefs.getString("password") ?? "";
      var remeberMe = prefs.getBool("remember_me") ?? false;

      print(remeberMe);
      print(user);
      print(password);
      if (remeberMe) {
        setState(() {
          _isRemember = true;
        });
        userNameController.text = user;
        passwordController.text = password;
      }
    } catch (e) {
      print(e);
    }
  }

  void _handleRemeberme(bool value) {
    print("Handle Rember Me");
    _isRemember = value;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('user', userNameController.text);
        prefs.setString('password', passwordController.text);
      },
    );
    setState(() {
      _isRemember = value;
    });
  }

  Widget buildRemember() {
    return Row(children: [
      Switch(
        value: _isRemember,
        onChanged: _handleRemeberme,
        activeColor: defaultColor,
      ),
      Text(
        "Remember".tr(),
        style: styleDefaultText,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Color.fromARGB(162, 245, 244, 242),
      ),
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
        child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildUserName(),
                const HeightSpacer(height: 0.02),
                buildPassword(),
                const HeightSpacer(height: 0.02),
                buildRemember(),
                FormError(errors: errors),
                DefaultButton(
                  color: defaultColor,
                  press: () async {
                    if (_formkey.currentState!.validate()) {
                      var response = await widget._loginController.gettToken(
                          userNameController.text, passwordController.text);

                      // Kiểm tra đăng nhập được hay không
                      if (response.accessToken == null) {
                        addError(error: erInformation);
                      } else {
                        errors.clear();
                        await widget._loginController.getEmployeePrivate();
                        await widget._loginController.getMenuPermisson();
                        await widget._loginController.getAnnouncements();
                        await widget._profileController.getStaff();
                        await widget._loginController.getMile();
                        await widget._inboxController.getNotifi();
                        await widget._loginController.initLocation();
                        Timer? timer = Timer(const Duration(seconds: 1), () {
                          Navigator.pushNamed(context, MainScreen.routeName);
                        });
                        showDialog(
                          context: context,
                          builder: (context) => const Loading(),
                        ).then((value) {
                          timer?.cancel();
                          timer = null;
                        });
                      }
                    }
                  },
                  text: "login",
                )
              ],
            )),
      ),
    );
  }
}
