// ignore_for_file: avoid_print

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fmbp/data/global/export_global.dart';
import 'package:fmbp/presentation/export_presentation.dart';
import 'package:location/location.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../models/export_model.dart';
import 'details_trip.dart';

final listTripAllDay = <TripRecord>[];
late Future<dynamic> futureTrip;

class BodyTripRecord extends StatefulWidget {
  final TripController _tripController;
  const BodyTripRecord(this._tripController, {Key? key}) : super(key: key);

  @override
  State<BodyTripRecord> createState() => _BodyTripRecordState();
}

class _BodyTripRecordState extends State<BodyTripRecord> {
  var staffID = globalUser.getStaffID;
  CalendarFormat formatCal = CalendarFormat.month;
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

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  void initState() {
    futureTrip = widget._tripController
        .getTrip(DateFormat("MM/dd/yyyy").format(DateTime.now()).toString());
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

    intTimeStart = 0;
    intTimeEnd = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 0,
            child: TableCalendar(
              focusedDay: selectedDay,
              firstDay: DateTime(1990),
              lastDay: DateTime(2050),
              onFormatChanged: (CalendarFormat format) {
                setState(() {
                  formatCal = format;
                });
              },
              startingDayOfWeek: StartingDayOfWeek.sunday,
              daysOfWeekVisible: true,
              //Day Changed
              onDaySelected: (DateTime selectDay, DateTime focusDay) {
                // listTripAllDay.clear();
                var chooseDate = DateFormat("MM/dd/yyyy").format(focusDay);
                setState(() {
                  selectedDay = selectDay;
                  focusedDay = focusDay;
                  futureTrip = widget._tripController.getTrip(chooseDate);
                });

                print("Click: $chooseDate");
                // print("FocusedDay: $focusedDay");
              },
              selectedDayPredicate: (DateTime date) {
                return isSameDay(selectedDay, date);
              },

              calendarStyle: const CalendarStyle(
                isTodayHighlighted: true,
                selectedDecoration: BoxDecoration(
                    color: Color.fromARGB(255, 252, 114, 72),
                    shape: BoxShape.circle),
                selectedTextStyle: TextStyle(color: Colors.white),
                todayDecoration: BoxDecoration(
                    color: defaultColor,
                    shape: BoxShape
                        .circle), //fromARGB(255, 11, 184, 100), shape: BoxShape.circle)
              ),

              headerStyle: HeaderStyle(
                  formatButtonVisible: true,
                  titleCentered: true,
                  formatButtonShowsNext: false,
                  formatButtonDecoration: BoxDecoration(
                    color: defaultColor,
                    borderRadius: BorderRadius.circular(13.0),
                  ),
                  formatButtonTextStyle: const TextStyle(color: Colors.white)),
            ),
          ),
          Expanded(
              flex: 0,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(
                      color: Colors.blueGrey,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.02),
                      child: Text(
                        "${"list_trip".tr()} - ${DateFormat("dd/MM/yyyy").format(focusedDay)}",
                        style: const TextStyle(
                          fontSize: 17,
                          color: defaultColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.02),
              child: FutureBuilder(
                future: futureTrip,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (listTripAllDay.isEmpty) {
                      return const SingleChildScrollView(
                          child: EmptyWidget(text: "no_data"));
                    } else {
                      return staffID == 0
                          ? const SingleChildScrollView(
                              child: EmptyWidget(text: "no_data"))
                          : ListView.builder(
                              physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              itemCount: listTripAllDay.length,
                              itemBuilder: (context, index) {
                                final intSelectDay =
                                    selectedDay.microsecondsSinceEpoch;
                                final convertSLD =
                                    DateTime.fromMicrosecondsSinceEpoch(
                                            intSelectDay)
                                        .add(const Duration(hours: -7));
                                final formatSLD =
                                    DateFormat('dd/MM/yyyy').format(convertSLD);
                                print("Select: $formatSLD");
                                final createDate =
                                    listTripAllDay[index].createDate;
                                final convertDate =
                                    DateTime.fromMicrosecondsSinceEpoch(
                                            createDate! * 1000)
                                        .add(const Duration(hours: -7));
                                final forrmatCreateDate =
                                    DateFormat('dd/MM/yyyy, hh:mm a')
                                        .format(convertDate);

                                if (formatSLD == "26/08/2022") {
                                  print("ĐÚNG NGÀY RỒI");
                                }
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailListTrip(
                                            widget._tripController,
                                            tripRecord: listTripAllDay[index]),
                                      ),
                                    );
                                  },
                                  child: CardCustom(
                                    widget: ListTile(
                                      title: Text(listTripAllDay[index]
                                          .staffName
                                          .toString()),
                                      subtitle: Text(
                                        "${"create_date".tr()}: $forrmatCreateDate",
                                        style: const TextStyle(
                                          color: defaultColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      leading: listTripAllDay[index]
                                                  .approved
                                                  .toString() ==
                                              "Approved"
                                          ? const IconCustom(
                                              iConURL:
                                                  "assets/icon/approved.png",
                                              size: 25)
                                          : const IconCustom(
                                              iConURL:
                                                  "assets/icon/pending.png",
                                              size: 25),
                                    ),
                                  ),
                                );
                              },
                            );
                    }
                  }
                  return const LoadingNoBox(color: defaultColor);
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: defaultColor,
        onPressed: () => showDialog(
            context: context, builder: (context) => addDayTrip(context)),
        label: Text("add_day_trip".tr()),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget addDayTrip(BuildContext context) {
    widget._tripController.getMile;
    return Scaffold(
      appBar: appBar(context),
      body: formAddDayTrip(context),
    );
  }

  Widget formAddDayTrip(BuildContext context) {
    return Form(
      key: _formkey,
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
        child: CardCustom(
          widget: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: SingleChildScrollView(
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
                Expanded(
                  flex: -1,
                  child: DefaultButton(
                    color: defaultColor,
                    text: "submit",
                    press: () async {
                      if (_formkey.currentState!.validate()) {
                        int tollFee, parkingFee;
                        var startMile = int.parse(_startMileController.text);
                        var endMile = int.parse(_endMileController.text);
                        if (intDateStart > intDateEnd) {
                          print("KHÔng hợp lệ");
                          addError(error: erFromToDate);
                        } else {
                          removeError(error: erFromToDate);
                          print("Done");
                        }

                        if (_tollFeeController.text == "") {
                          tollFee = 0;
                        } else {
                          tollFee = int.parse(_tollFeeController.text);
                        }
                        if (_parkingFeeController.text == "") {
                          parkingFee = 0;
                        } else {
                          parkingFee = int.parse(_parkingFeeController.text);
                        }

                        if (startMile >= endMile) {
                          addError(error: erStartMile_EndMile.tr());
                        } else {
                          removeError(error: erStartMile_EndMile.tr());
                        }

                        if (errors.isEmpty) {
                          await widget._tripController.setLocationWhenAddTrip();
                          await widget._tripController
                              .saveAddDayTrip(
                                startMile,
                                "${_startDateController.text} ${_startTimeController.text}",
                                endMile,
                                "${_endDateController.text} ${_endTimeController.text}",
                                _routeController.text,
                                _tripMemoController.text,
                                tollFee,
                                parkingFee,
                              )
                              .whenComplete(() => showDialog(
                                    context: context,
                                    builder: (context) => const SuccessFull(
                                      text: "save_success",
                                    ),
                                  ).whenComplete(() {
                                    setState(() {
                                      _startMileController.text = "";
                                      _startDateController.text = "";
                                      _startTimeController.text = "";
                                      _endMileController.text = "";
                                      _endDateController.text = "";
                                      _endTimeController.text = "";
                                      _routeController.text = "";
                                      futureTrip = widget._tripController
                                          .getTrip(DateFormat("MM/dd/yyyy")
                                              .format(DateTime.now())
                                              .toString());
                                    });
                                  }))
                              .whenComplete(() => Navigator.pop(context));
                        } else if (errors.isNotEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) => DialogError(
                              widget: FormError(
                                errors: errors,
                              ),
                            ),
                          );
                        }
                      }
                      return;
                    },
                  ), // buildSubmitButton(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
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
                  },
                );
              }).then(
            (exit) {
              if (exit == null) return;
              if (exit) {
                clearText();
                Navigator.pop(context);
                setState(() {
                  _startDateController.text = defaultDate;
                  _endDateController.text = defaultDate;
                });
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
      title: Text("add_day_trip".tr().toUpperCase()),
      // automaticallyImplyLeading: false,
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
