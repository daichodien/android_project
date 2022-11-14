// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fmbp/presentation/export_presentation.dart';
import 'package:fmbp/presentation/screens/auth/login/index.dart';

class FormRegister extends StatefulWidget {
  final LoginController _loginController;
  const FormRegister(
    this._loginController, {
    Key? key,
  }) : super(key: key);

  @override
  State<FormRegister> createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  final List<String?> errors = [];
  final _formkeyRegister = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  bool _obscureText = true;
  bool isChecked = false;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return textDarkBlue;
  }

  String? firstname;
  String? lastName;
  String? username;
  String? password;
  String? confirmPassword;
  String? phone;
  String? email;

  @override
  void initState() {
    setState(() {
      firstNameController.text = "";
      lastNameController.text = "";
      userNameController.text = "";
      passwordController.text = "";
      confirmPasswordController.text = "";
      phoneController.text = "";
      emailController.text = "";
    });

    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    emailController.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formkeyRegister,
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                child: Column(
                  children: [
                    const HeightSpacer(height: 0.01),
                    buildRow1(context),
                    const HeightSpacer(height: 0.02),
                    buildUserName(),
                    const HeightSpacer(height: 0.02),
                    buildPassword(),
                    const HeightSpacer(height: 0.02),
                    buildConfirmPassword(),
                    const HeightSpacer(height: 0.02),
                    buildPhone(),
                    const HeightSpacer(height: 0.02),
                    buildEmail(),
                    const HeightSpacer(height: 0.01),
                    buildCheckbox(),
                    const HeightSpacer(height: 0.02),
                    FormError(errors: errors),
                  ],
                ),
              ),
            )),
            Expanded(
                flex: -1,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.width * 0.02),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: DefaultButton(
                      color: defaultColor,
                      text: "register",
                      press: () async {
                        print("Đăng ký");
                        if (_formkeyRegister.currentState!.validate()) {
                          if (errors.isEmpty) {
                            var register =
                                await widget._loginController.register(
                              "${firstNameController.text} ${lastNameController.text}",
                              userNameController.text,
                              passwordController.text,
                              firstNameController.text,
                              lastNameController.text,
                              emailController.text,
                              phoneController.text,
                            );
                            var json = jsonDecode(register.body);
                            var payload = json["payload"];
                            if (payload == -1) {
                              showDialog(
                                context: context,
                                builder: (context) => DialogError(
                                  widget: Text("Username has been used".tr()),
                                ),
                              );
                            } else if (payload == -2) {
                              print("Mobile ton tai");
                              showDialog(
                                context: context,
                                builder: (context) => DialogError(
                                  widget:
                                      Text("Mobile phone has been used".tr()),
                                ),
                              );
                            } else if (payload == -3) {
                              print("Email ton tai");
                              showDialog(
                                context: context,
                                builder: (context) => DialogError(
                                  widget: Text("Email has been used".tr()),
                                ),
                              );
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) => const SuccessFull(
                                      text: "register_success")).whenComplete(
                                () => Navigator.pushNamed(
                                    context, LoginScreen.routeName),
                              );
                            }
                          }
                        }
                      },
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget buildCheckbox() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Checkbox(
            checkColor: textWhite,
            value: isChecked,
            fillColor: MaterialStateProperty.resolveWith(getColor),
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
              });
            },
          ),
        ),
        Expanded(
          flex: 7,
          child: Text(
            "auto_delete".tr(),
            style: styleDefaultText,
            maxLines: 2,
            overflow: TextOverflow.clip,
          ),
        ),
      ],
    );
  }

  Widget buildPhone() {
    return TextFormField(
      controller: phoneController,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      onSaved: (newValue) => phone = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: erNullPhone.tr());
        }
        phone = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: erNullPhone.tr());
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "phone".tr(),
        hintText: "Enter your number phone".tr(),
        labelStyle: styleLabelInput,
        hintStyle: styleHintInput,
        suffixIcon: const Icon(
          Icons.phone,
          color: defaultColor,
        ),
      ),
    );
  }

  Widget buildEmail() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: erNullEmail.tr());
        }
        email = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: erNullEmail.tr());
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "email".tr(),
        hintText: "Enter your your email".tr(),
        labelStyle: styleLabelInput,
        hintStyle: styleHintInput,
        suffixIcon: const Icon(
          Icons.email,
          color: defaultColor,
        ),
      ),
    );
  }

  Widget buildConfirmPassword() {
    return TextFormField(
      obscureText: _obscureText,
      keyboardType: TextInputType.visiblePassword,
      controller: confirmPasswordController,
      onSaved: (newValue) => confirmPassword = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: erNullPassword.tr());
        }
        if (value == passwordController.text) {
          removeError(error: erPassNotMatch.tr());
        }
        confirmPassword = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: erNullPassword.tr());
        }
        if (value != passwordController.text) {
          addError(error: erPassNotMatch.tr());
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "confirmPass".tr(),
        hintText: "Enter your password".tr(),
        labelStyle: styleLabelInput,
        hintStyle: styleHintInput,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          icon: Icon(
            _obscureText ? Icons.lock : Icons.lock_open,
            color: defaultColor,
          ),
        ),
      ),
    );
  }

  Widget buildPassword() {
    return TextFormField(
      obscureText: _obscureText,
      controller: passwordController,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: erNullPassword.tr());
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: erNullPassword.tr());
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "passWord".tr(),
        hintText: "Enter your password".tr(),
        labelStyle: styleLabelInput,
        hintStyle: styleHintInput,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          icon: Icon(
            _obscureText ? Icons.lock : Icons.lock_open,
            color: defaultColor,
          ),
        ),
      ),
    );
  }

  Widget buildUserName() {
    return TextFormField(
      controller: userNameController,
      onSaved: (newValue) => username = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: erNullUserName.tr());
        }
        username = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: erNullUserName.tr());
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "userName".tr(),
        hintText: "Enter your user name".tr(),
        labelStyle: styleLabelInput,
        hintStyle: styleHintInput,
        suffixIcon: const Icon(
          Icons.person,
          color: defaultColor,
        ),
      ),
    );
  }

  Widget buildRow1(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: TextFormField(
            controller: firstNameController,
            onSaved: (newValue) => firstname = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: erNullFirstName.tr());
              }
              firstname = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: erNullFirstName.tr());
              }
              return null;
            },
            decoration: InputDecoration(
                labelText: "1_name".tr(),
                hintText: "1_name".tr(),
                labelStyle: styleLabelInput,
                hintStyle: styleHintInput,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: const Icon(
                  Icons.person,
                  color: defaultColor,
                )),
          ),
        ),
        Expanded(
          flex: 0,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
          ),
        ),
        Expanded(
          flex: 4,
          child: TextFormField(
            controller: lastNameController,
            onSaved: (newValue) => lastName = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: erNullSecondName.tr());
              }
              lastName = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: erNullSecondName.tr());
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "2_name".tr(),
              hintText: "2_name".tr(),
              labelStyle: styleLabelInput,
              hintStyle: styleHintInput,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: const Icon(
                Icons.person,
                color: defaultColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
