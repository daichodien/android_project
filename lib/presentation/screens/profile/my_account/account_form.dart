import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fmbp/data/global/profile_driver.dart';
import 'package:fmbp/data/global/user.dart';

import 'package:fmbp/presentation/export_presentation.dart';
import '../../../../models/export_model.dart';
import '../components/item_account.dart';

class FormAccount extends StatefulWidget {
  final ProfileController _profileController;
  const FormAccount(this._profileController, {Key? key}) : super(key: key);

  @override
  State<FormAccount> createState() => _FormAccountState();
}

class _FormAccountState extends State<FormAccount> {
  final staffID = globalUser.getStaffID;
  final fleet = globalDriver.getFleetDesc;

  final _formkey = GlobalKey<FormState>();
  late Future<DriverModel> futureDriver;
  final _fullNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _icNumberController = TextEditingController();
  final _licenseNumberController = TextEditingController();
  final _fleetDescController = TextEditingController();
  String? icNumber;
  final List<String?> errors = [];
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
  void initState() {
    if (staffID == 0) {
      setState(() {
        _icNumberController.text == "";
        _licenseNumberController.text = "";
        _fleetDescController.text = "";
      });
    } else {
      widget._profileController.getStaff();

      _icNumberController.text = globalDriver.getIcNumber.toString();
      _licenseNumberController.text = globalDriver.getLicenseNumber.toString();
      _fleetDescController.text = globalDriver.getFleetDesc.toString();
    }
    _fullNameController.text = globalDriver.getFullName.toString();
    _mobileController.text = globalDriver.getMobile.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
      child: Form(
        key: _formkey,
        child: staffID == null
            ? Column(
                children: [
                  ItemAccount(
                    controller: _fullNameController,
                    edit: false,
                    iconUrl: "assets/icon/avt.png",
                    content: "full_name",
                  ),
                ],
              )
            : Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ItemAccount(
                            controller: _fullNameController,
                            edit: false,
                            iconUrl: "assets/icon/avt.png",
                            content: "full_name",
                          ),
                          ItemAccount(
                            controller: _mobileController,
                            edit: false,
                            iconUrl: "assets/icon/phone.png",
                            content: "phone",
                          ),
                          staffID == 0
                              ? Container()
                              : Column(
                                  children: [
                                    buildIcNumber(),
                                    buildLicensenNumber(),
                                    fleet == null
                                        ? const ItemAccount(
                                            // controller: _fleetDescController,
                                            edit: false,
                                            iconUrl: "assets/icon/card_car.png",
                                            content: "current_fleet",
                                          )
                                        : ItemAccount(
                                            controller: _fleetDescController,
                                            edit: false,
                                            iconUrl: "assets/icon/card_car.png",
                                            content: "current_fleet",
                                          ),
                                    FormError(errors: errors),
                                  ],
                                )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: -1,
                    child: staffID != 0
                        ? DefaultButton(
                            color: defaultColor,
                            press: () async {
                              if (_formkey.currentState!.validate()) {
                                await widget._profileController
                                    .updateStaff(_icNumberController.text,
                                        _licenseNumberController.text)
                                    .whenComplete(
                                      () => showDialog(
                                        context: context,
                                        builder: (context) => const SuccessFull(
                                            text: "save_success"),
                                      ),
                                    )
                                    .whenComplete(() => Navigator.pop(context));
                              }
                            },
                            text: "update",
                          )
                        : Container(),
                  ),
                ],
              ),
      ),
    );
  }

  InputDecoration inputDecoration(String iconURL) {
    return InputDecoration(
      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      fillColor: bgDrawerColor,
      filled: true,
      prefixIcon: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
        child: IconCustom(iConURL: iconURL, size: 25),
      ),
      suffixIconColor: Colors.amber,
      suffixIcon: const Icon(
        Icons.edit,
        color: Colors.green,
      ),
    );
  }

  TextStyle styleText() {
    return const TextStyle(
      fontWeight: FontWeight.bold,
      wordSpacing: 2,
      letterSpacing: 0.3,
      color: textBlack,
    );
  }

  TextStyle styleText2() {
    return const TextStyle(
      fontWeight: FontWeight.w600,
      wordSpacing: 2,
      letterSpacing: 0.5,
      color: textDarkBlue,
    );
  }

  Widget buildIcNumber() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("ic_no".tr(), style: styleText()),
          const HeightSpacer(height: 0.0080),
          TextFormField(
            controller: _icNumberController,
            enabled: true,
            onSaved: (newValue) => icNumber = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: erNullIcNumber.tr());
              }
              return;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: erNullIcNumber.tr());
                return "";
              }
              return null;
            },
            style: styleText2(),
            autofocus: false,
            decoration: inputDecoration("assets/icon/ic_number.png"),
          ),
        ],
      ),
    );
  }

  Widget buildLicensenNumber() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("licensen".tr(), style: styleText()),
          const HeightSpacer(height: 0.0080),
          TextFormField(
            controller: _licenseNumberController,
            enabled: true,
            onSaved: (newValue) => icNumber = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: erNullLicNumber.tr());
              }
              return;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: erNullLicNumber.tr());
                return "";
              }
              return null;
            },
            style: styleText2(),
            autofocus: false,
            decoration: inputDecoration("assets/icon/licensen.png"),
          ),
        ],
      ),
    );
  }
}
