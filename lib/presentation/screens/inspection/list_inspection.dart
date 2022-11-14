import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fmbp/presentation/export_presentation.dart';

import '../../../models/export_model.dart';

final listAllInspection = <ListInpection>[];

class ListInspection extends StatefulWidget {
  final InspectionController _inspectionController;
  const ListInspection(this._inspectionController, {Key? key})
      : super(key: key);

  @override
  State<ListInspection> createState() => _ListInspectionState();
}

class _ListInspectionState extends State<ListInspection> {
  late Future<dynamic> futureList;
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  late int intDateStart;
  late int intDateEnd;
  DateTime toDay = DateTime.now();
  DateTime startDay = DateTime(2000);
  DateTime endDay = DateTime(2200);
  @override
  void initState() {
    setState(() {
      _startDateController.text = "";
      _endDateController.text = "";
    });
    futureList = widget._inspectionController.getInspection();
    // futureList = getCheckList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Expanded(flex: 0, child: buildFilter(context)),
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
                      "list_check".tr(),
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
            future: futureList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return listAllInspection.isEmpty
                    ? EmptyWidget(text: "no_data".tr())
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: listAllInspection.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              // int? clId = listAllInspection[index].clId;
                              // widget._inspectionController
                              //     .getCheckListDetail(clId!);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             CheckListDetailScreen(
                              //               clId: clId!,
                              //             )));

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => TestABC(),
                              //     ));
                            },
                            child: CardCustom(
                              widget: Padding(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width * 0.02),
                                child: Column(
                                  children: [
                                    buildFleeDesc(context, index),
                                    buildDateCheck(context, index),
                                    buildDriverName(context, index),
                                    buildScore1(context, index),
                                    buildScore2(context, index),
                                    buildCreateBy(context, index)
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
              }
              return const LoadingNoBox(color: defaultColor);
            },
          ),
        )),
      ],
    );
  }

  Widget buildFilter(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
      child: Column(
        children: [
          buildFromTo(context),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.01,
          ),
          DefaultButton(
            color: defaultColor,
            press: () {
              showDialog(
                  context: context,
                  builder: (context) => SuccessFull(text: "update".tr()));
            },
            text: "search".tr(),
          )
        ],
      ),
    );
  }

  Widget buildFromTo(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 2.2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitle(
                text: "start_date".tr(),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _startDateController,
                decoration: InputDecoration(
                  hintText: "start_date".tr(),
                  suffixIcon: IconButton(
                    onPressed: () async {
                      DateTime? formDate = await showDatePicker(
                        context: context,
                        initialDate: toDay,
                        firstDate: startDay,
                        lastDate: toDay,
                      );
                      if (formDate != null) {
                        String formattedStartDate =
                            DateFormat('dd/MM/yyyy').format(formDate);
                        intDateStart = formDate.microsecondsSinceEpoch;
                        setState(() {
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
        SizedBox(
          width: MediaQuery.of(context).size.width / 2.2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitle(
                text: "end_date".tr(),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _endDateController,
                decoration: InputDecoration(
                  hintText: "end_date".tr(),
                  suffixIcon: IconButton(
                    onPressed: () async {
                      DateTime? formDate = await showDatePicker(
                        context: context,
                        initialDate: toDay,
                        firstDate: startDay,
                        lastDate: toDay,
                      );
                      if (formDate != null) {
                        String formattedStartDate =
                            DateFormat('dd/MM/yyyy').format(formDate);
                        intDateEnd = formDate.microsecondsSinceEpoch;
                        setState(() {
                          _endDateController.text = formattedStartDate;
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
      ],
    );
  }

  Widget buildFleeDesc(BuildContext context, int index) {
    return Row(
      children: [
        const IconCustom(iConURL: "assets/icon/trip_record.png", size: 30),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
        Text(
          listAllInspection[index].equipmentCode.toString(),
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget buildDateCheck(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width * 0.01),
      child: Row(
        children: [
          Expanded(
            child: Text("date_check".tr(), style: styleDefaultText),
          ),
          Expanded(
            child: Text(
              DateFormat('dd/MM/yyy HH:mm ')
                  .format(DateTime.fromMicrosecondsSinceEpoch(
                          listAllInspection[index].createDate! * 1000)
                      .add(const Duration(hours: -7)))
                  .toString(),
              style: styleDefaultText,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDriverName(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width * 0.01),
      child: Row(
        children: [
          Expanded(
            child: Text("name_driver".tr(), style: styleDefaultText),
          ),
          Expanded(
            child: Text(
              listAllInspection[index].driverName.toString(),
              style: styleDefaultText,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildScore1(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width * 0.01),
      child: Row(
        children: [
          Expanded(
            child: Text("sum_score".tr(), style: styleDefaultText),
          ),
          Expanded(
            child: Text(
              listAllInspection[index].totalScore.toString(),
              style: styleDefaultText,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildScore2(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width * 0.01),
      child: Row(
        children: [
          Expanded(
            child: Text("sum_score2".tr(), style: styleDefaultText),
          ),
          Expanded(
            child: Text(
              listAllInspection[index].totalAllocatedScore.toString(),
              style: styleDefaultText,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCreateBy(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width * 0.01),
      child: Row(
        children: [
          Expanded(
            child: Text("create_by".tr(), style: styleDefaultText),
          ),
          Expanded(
            child: Text(
              listAllInspection[index].createUserName.toString(),
              style: styleDefaultText,
            ),
          ),
        ],
      ),
    );
  }
}
