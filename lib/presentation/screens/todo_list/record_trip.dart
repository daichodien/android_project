// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fmbp/data/global/export_global.dart';
import 'package:fmbp/presentation/export_presentation.dart';
import 'package:fmbp/presentation/screens/todo_list/index.dart';
import 'package:location/location.dart';

import '../../../models/export_model.dart';

class SaveTrip extends StatefulWidget {
  const SaveTrip(this._tripController, this._todoController,
      {Key? key, required this.toDoList})
      : super(key: key);
  final ToDoList toDoList;
  final TripController _tripController;
  final TodoController _todoController;

  @override
  State<SaveTrip> createState() => _SaveTripState();
}

class _SaveTripState extends State<SaveTrip> {
  var staffID = globalUser.getStaffID;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
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

  var location = Location();
  final _formkey = GlobalKey<FormState>();
  final _startMileController = TextEditingController();
  final _endMileController = TextEditingController();
  final _routeController = TextEditingController();
  final _parkingFeeController = TextEditingController();
  final _tollFeeController = TextEditingController();
  final _tripMemoController = TextEditingController();
  final _startDateController = TextEditingController();
  late int intDateStart;
  final _startTimeController = TextEditingController();
  late int intDateEnd;
  final _endDateController = TextEditingController();
  late int intTimeStart;
  final _endTimeController = TextEditingController();
  late int intTimeEnd;
  DateTime toDay = DateTime.now();
  DateTime startDay = DateTime(2000);
  DateTime endDay = DateTime(2200);
  final defaultDate =
      DateFormat("MM/dd/yyyy").format(DateTime.now()).toString();
  @override
  void initState() {
    intDateStart = 0;
    intDateEnd = 0;
    setState(() {
      _startMileController.text = "";
      _startDateController.text = defaultDate;
      _startTimeController.text = "";

      _endMileController.text = "";
      _endDateController.text = defaultDate;
      _endTimeController.text = "";
      _routeController.text = "";
    });
    widget._tripController.getMile();
    intTimeStart = 0;
    intTimeEnd = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: formTripRecord(context),
    );
  }

  Widget formTripRecord(BuildContext context) {
    return Form(
      key: _formkey,
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
        child: Column(
          children: [
            Expanded(flex: 0, child: SizedBox(child: loadBook(context))),
            Expanded(
              child: CardCustom(
                  widget: Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.01),
                          child: Column(
                            children: [
                              buildStartMile(),
                              const HeightSpacer(height: 0.01),
                              buildStartDateTime(context),
                              const HeightSpacer(height: 0.01),
                              buildEndMile(),
                              const HeightSpacer(height: 0.01),
                              buildEndDateTime(context),
                              const HeightSpacer(height: 0.01),
                              buildRoute(),
                              const HeightSpacer(height: 0.01),
                              buildRowFee(context),
                              const HeightSpacer(height: 0.01),
                              buildTripMemo(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: -1,
                      child: DefaultButton(
                        color: defaultColor,
                        text: "submit".toUpperCase(),
                        press: () async {
                          if (_formkey.currentState!.validate()) {
                            int tollFee, parkingFee, brId;
                            brId = widget.toDoList.brId!;
                            var startMile =
                                int.parse(_startMileController.text);
                            var endMile = int.parse(_endMileController.text);

                            if (_tollFeeController.text == "") {
                              tollFee = 0;
                            } else {
                              tollFee = int.parse(_tollFeeController.text);
                            }
                            if (_parkingFeeController.text == "") {
                              parkingFee = 0;
                            } else {
                              parkingFee =
                                  int.parse(_parkingFeeController.text);
                            }

                            if (startMile >= endMile) {
                              addError(error: erStartMile_EndMile.tr());
                            } else {
                              removeError(error: erStartMile_EndMile.tr());
                            }
                            if (intDateStart > intDateEnd) {
                              addError(error: erFromToDate);
                            } else {
                              removeError(error: erFromToDate);
                            }

                            if (errors.isEmpty) {
                              await widget._tripController
                                  .setLocationWhenAddTrip();
                              final response =
                                  await widget._todoController.saveBookTrip(
                                startMile,
                                "${_startDateController.text} ${_startTimeController.text}",
                                endMile,
                                "${_endDateController.text} ${_endTimeController.text}",
                                _routeController.text,
                                _tripMemoController.text,
                                tollFee,
                                parkingFee,
                                brId,
                              );
                              if (response.statusCode == 200) {
                                var json = jsonDecode(response.body);
                                var success = json["success"];
                                if (success == true) {
                                  buildSubmitDone(context).whenComplete(() =>
                                      Navigator.pushNamed(
                                          context, ToDoListScreen.routeName));
                                } else {
                                  buildErrorSubmit(context);
                                }
                              }
                            } else if (errors.isNotEmpty) {
                              buildError(context);
                            }
                          }
                        },
                      ),
                    )
                  ],
                ),
              )),
            )
          ],
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: Text("save_trip".tr().toUpperCase()),
      leading: IconButton(
        onPressed: () {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AreYouSure(
                  text: "are_you_sure_cancel",
                  pressCanel: () {
                    Navigator.pop(context, false);
                  },
                  pressOK: () {
                    Navigator.pop(context, true);
                    setState(() {
                      _startDateController.text = defaultDate;
                      _endDateController.text = defaultDate;
                    });
                  },
                );
              }).then(
            (exit) {
              if (exit == null) return;
              if (exit) {
                clearText();
                Navigator.pop(context);
              } else {}
              return;
            },
          );
        },
        icon: Image.asset(
          "assets/icon/arrow_left.png",
          color: Colors.white,
          width: 30,
        ),
      ),
    );
  }

  Widget loadBook(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: bgDrawerColor,
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: IconCustom(
                          iConURL: "assets/icon/card_car.png", size: 30),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        widget.toDoList.bookNo.toString(),
                        style: const TextStyle(
                          color: textRed,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )),
                Expanded(
                    child: Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: IconCustom(
                          iConURL: "assets/icon/approved.png", size: 30),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        widget.toDoList.bookStatus!.tr().toString(),
                        style: const TextStyle(
                          color: defaultColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )),
              ],
            ),
            const HeightSpacer(height: 0.02),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 1,
                        child: IconCustom(
                            iConURL: "assets/icon/location_from.png", size: 30),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          widget.toDoList.pickUpPlace.toString(),
                          style: const TextStyle(
                            color: textBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 1,
                        child: IconCustom(
                            iConURL: "assets/icon/location_to.png", size: 30),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          widget.toDoList.returnPlace.toString(),
                          style: const TextStyle(
                            color: textBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                )
                // Expanded(
                //     child: Row(
                //   children: [
                //     const IconCustom(
                //         iConURL: "assets/icon/location_from.png", size: 30),
                //     SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                //     AutoSizeText(
                //       widget.toDoList.pickUpPlace.toString(),
                //       style: const TextStyle(
                //         color: txtColor,
                //         fontWeight: FontWeight.bold,
                //       ),
                //       maxLines: 2,
                //     )
                //   ],
                // )),
                // Expanded(
                //     child: Row(
                //   children: [
                //     const IconCustom(
                //         iConURL: "assets/icon/location_to.png", size: 30),
                //     SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                //     Text(
                //       widget.toDoList.returnPlace.toString(),
                //       style: const TextStyle(
                //         color: txtColor,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     )
                //   ],
                // )),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildStartMile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTitle(
          text: "start_mile".tr(),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: _startMileController,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          validator: (value) {
            if (value!.isEmpty) {
              addError(error: erNullStartMile.tr());
              return "";
            } else if (value.isNotEmpty) {
              removeError(error: erNullStartMile.tr());
            }

            return null;
          },
          decoration: InputDecoration(
              hintText: "start_mile".tr(),
              suffixIcon: IconButton(
                onPressed: () {
                  widget._tripController.getMile();
                  setState(() {
                    _startMileController.text =
                        globalMile.getLastMile.toString();
                  });
                },
                icon:
                    const IconCustom(iConURL: "assets/icon/past.png", size: 30),
              )),
        ),
      ],
    );
  }

  Widget buildRowFee(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 4,
          child: SizedBox(
            child: buildParkingFee(),
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
          child: SizedBox(
            child: buildTollFee(),
          ),
        )
      ],
    );
  }

  Widget buildEndDateTime(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTitle(
                  text: "end_date".tr(),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _endDateController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      addError(error: erNullEndDate.tr());
                      return "";
                    }
                    if (value.isNotEmpty) {
                      removeError(error: erNullEndDate.tr());
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "end_date".tr(),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        DateTime? toDate = await showDatePicker(
                          context: context,
                          initialDate: toDay,
                          firstDate: startDay,
                          lastDate: endDay,
                        );
                        if (toDate != null) {
                          String formattedEndDate =
                              DateFormat('MM/dd/yyyy').format(toDate);

                          setState(() {
                            intDateEnd = toDate.microsecondsSinceEpoch;
                            _endDateController.text = formattedEndDate;
                          });
                        }
                      },
                      icon: const IconCustom(
                        iConURL: "assets/icon/navbar_calendar.png",
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTitle(
                  text: "end_time".tr(),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _endTimeController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      addError(error: erNullEndTime.tr());
                      return "";
                    }
                    if (value.isNotEmpty) {
                      removeError(error: erNullEndTime.tr());
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "end_time".tr(),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        final TimeOfDay? result = await showTimePicker(
                            builder: (context, child) {
                              return MediaQuery(
                                  data: MediaQuery.of(context)
                                      .copyWith(alwaysUse24HourFormat: true),
                                  child: child!);
                            },
                            context: context,
                            initialTime: TimeOfDay.now());
                        if (result != null) {
                          String format(BuildContext context) {
                            assert(debugCheckHasMediaQuery(context));
                            assert(debugCheckHasMaterialLocalizations(context));
                            final MaterialLocalizations localizations =
                                MaterialLocalizations.of(context);
                            return localizations.formatTimeOfDay(
                              result,
                              alwaysUse24HourFormat:
                                  MediaQuery.of(context).alwaysUse24HourFormat,
                            );
                          }

                          setState(() {
                            _endTimeController.text = "${result.to24hours()}";
                            intTimeEnd = result.hashCode;
                          });
                        }
                      },
                      icon: const IconCustom(
                        iConURL: "assets/icon/time.png",
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildStartDateTime(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 4,
          child: SizedBox(
            // width: MediaQuery.of(context).size.width / 2.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTitle(
                  text: "start_date".tr(),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _startDateController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      addError(error: erNullStartDate.tr());
                      return "";
                    }
                    if (value.isNotEmpty) {
                      removeError(error: erNullStartDate.tr());
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "start_date".tr(),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        DateTime? formDate = await showDatePicker(
                          context: context,
                          initialDate: toDay,
                          firstDate: startDay,
                          lastDate: endDay,
                        );
                        if (formDate != null) {
                          String formattedStartDate =
                              DateFormat('MM/dd/yyyy').format(formDate);
                          setState(() {
                            intDateStart = formDate.microsecondsSinceEpoch;
                            _startDateController.text = formattedStartDate;
                          });
                        }
                      },
                      icon: const IconCustom(
                        iConURL: "assets/icon/navbar_calendar.png",
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
          child: SizedBox(
            // width: MediaQuery.of(context).size.width / 2.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTitle(
                  text: "start_time".tr(),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _startTimeController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      addError(error: erNullStartTime.tr());
                      return "";
                    }
                    if (value.isNotEmpty) {
                      removeError(error: erNullStartTime.tr());
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "start_time".tr(),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        final TimeOfDay? result = await showTimePicker(
                          builder: (context, child) {
                            return MediaQuery(
                                data: MediaQuery.of(context).copyWith(
                                  alwaysUse24HourFormat: true,
                                ),
                                child: child!);
                          },
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (result != null) {
                          String format(BuildContext context) {
                            assert(debugCheckHasMediaQuery(context));
                            assert(debugCheckHasMaterialLocalizations(context));
                            final MaterialLocalizations localizations =
                                MaterialLocalizations.of(context);
                            return localizations.formatTimeOfDay(
                              result,
                              alwaysUse24HourFormat:
                                  MediaQuery.of(context).alwaysUse24HourFormat,
                            );
                          }

                          print(result);

                          setState(() {
                            _startTimeController.text = "${result.to24hours()}";
                            intTimeStart = result.hashCode;
                          });
                        }
                      },
                      icon: const IconCustom(
                        iConURL: "assets/icon/time.png",
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildTripMemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextTitle(text: "trip_memo".tr()),
        const SizedBox(height: 5),
        TextFormField(
          controller: _tripMemoController,
          decoration: InputDecoration(
            hintText: "trip_memo".tr(),
          ),
        ),
      ],
    );
  }

  Widget buildTollFee() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextTitle(text: "toll_fee".tr()),
        const SizedBox(height: 5),
        TextFormField(
          controller: _tollFeeController,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
            // CurrencyInputFormatter()
          ],
          decoration: InputDecoration(
            hintText: "toll_fee".tr(),
          ),
        ),
      ],
    );
  }

  Widget buildParkingFee() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextTitle(text: "parking_fee".tr()),
        const SizedBox(height: 5),
        TextFormField(
          controller: _parkingFeeController,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
            // CurrencyInputFormatter(),
          ],
          decoration: InputDecoration(
            hintText: "parking_fee".tr(),
          ),
        ),
      ],
    );
  }

  Widget buildRoute() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTitle(
          text: "route".tr(),
        ),
        const SizedBox(height: 5),
        TextFormField(
          maxLines: 5,
          keyboardType: TextInputType.multiline,
          controller: _routeController,
          validator: (value) {
            if (value!.isEmpty) {
              addError(error: erNullRoute.tr());
              return "";
            }
            if (value.isNotEmpty) {
              removeError(error: erNullRoute.tr());
            }
            return null;
          },
          decoration: InputDecoration(hintText: "route".tr()),
        ),
      ],
    );
  }

  Widget buildEndMile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTitle(
          text: "end_mile".tr(),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: _endMileController,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly, // chỉ nhập số
          ],
          validator: (value) {
            if (value!.isEmpty) {
              addError(error: erNullEndtMile.tr());
              return "";
            } else if (value.isNotEmpty) {
              removeError(error: erNullEndtMile.tr());
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: "end_mile".tr(),
          ),
        ),
      ],
    );
  }

  Future<dynamic> buildError(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => DialogError(
        widget: FormError(
          errors: errors,
        ),
      ),
    );
  }

  Future<dynamic> buildSubmitDone(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => SuccessFull(text: "save_success".tr()));
  }

  Future<dynamic> buildErrorSubmit(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => DialogError(
              widget: Text(
                "save_fail".tr(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ));
  }

  clearText() {
    _startMileController.clear();
    _startDateController.clear();
    _startTimeController.clear();
    _endMileController.clear();
    _endDateController.clear();
    _endTimeController.clear();

    _routeController.clear();
    _tollFeeController.clear();
    _parkingFeeController.clear();
    _tripMemoController.clear();
  }
}
