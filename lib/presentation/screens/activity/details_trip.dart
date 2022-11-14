import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fmbp/presentation/export_presentation.dart';
import 'package:fmbp/presentation/screens/activity/components/map.dart';

import '../../../models/export_model.dart';
import '../main/main_screen.dart';
import 'body.dart';
import 'components/camera.dart';
import 'components/padding.dart';

class DetailListTrip extends StatefulWidget {
  final TripController _tripController;

  const DetailListTrip(this._tripController,
      {Key? key, required this.tripRecord})
      : super(key: key);
  final TripRecord tripRecord;

  @override
  State<DetailListTrip> createState() => _DetailListTripState();
}

class _DetailListTripState extends State<DetailListTrip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("detail_trip".tr()),
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        child: CardCustom(
          widget: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildRow1(context),
                const HeightSpacer(height: 0.02),
                buildRow2(),
                const Divider(
                  color: Colors.grey,
                  height: 2,
                ),
                const HeightSpacer(height: 0.02),
                buildFrom(),
                const HeightSpacer(height: 0.02),
                buildTo(),
                const HeightSpacer(height: 0.02),
                buildRoute(),
                const HeightSpacer(height: 0.02),
                buildTable(context),
                const HeightSpacer(height: 0.02),
                Camera(context: context),
                MapWithMarker(context: context)
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: widget.tripRecord.approved == "Pending"
          ? Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
              child: FloatingActionButton.extended(
                backgroundColor: textRed,
                onPressed: () {
                  final id = (widget.tripRecord.trId);
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (index) {
                        return AreYouSure(
                          text: "are_you_sure_delete",
                          pressCanel: () {
                            Navigator.pop(context, false);
                          },
                          pressOK: () {
                            Navigator.pop(context, true);
                          },
                        );
                      }).then((exit) async {
                    if (exit == null) return futureTrip;
                    if (exit) {
                      var response =
                          await widget._tripController.deleteTrip(id!);
                      if (response.statusCode == 200) {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              const SuccessFull(text: "delete_success"),
                        ).whenComplete(
                          () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainScreen())),
                        );
                      }
                    } else {}
                  });
                },
                label: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("delete_trip".tr()),
                      const WidthSpacer(width: 0.04),
                      Image.asset(
                        "assets/icon/delete.png",
                        color: textWhite,
                        width: 25,
                      )
                    ],
                  ),
                ),
              ))
          : Container(),
    );
  }

  DateFormat dateFormat() => DateFormat('dd/MM/yyyy, hh:mm a');

  Widget buildRow1(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.,
      children: [
        Expanded(
            child: Row(
          children: [
            const Expanded(
              flex: 1,
              child: IconCustom(iConURL: "assets/icon/avt.png", size: 25),
            ),
            Expanded(
              flex: 4,
              child: Text(
                widget.tripRecord.staffName.toString(),
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
          ],
        )),
        Expanded(
          child: widget.tripRecord.approved == "Approved"
              ? Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: IconCustom(
                          iConURL: "assets/icon/approved.png", size: 20),
                    ),
                    Expanded(
                        flex: 4,
                        child: Text(
                          "Accepted".tr(),
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ))
                  ],
                )
              : Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: IconCustom(
                          iConURL: "assets/icon/pending.png", size: 20),
                    ),
                    Expanded(
                        flex: 4,
                        child: Text(
                          "pending".tr(),
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ))
                  ],
                ),
        ),
      ],
    );
  }

  Widget buildRow2() {
    return Row(
      children: [
        const Expanded(
            flex: 1,
            child:
                IconCustom(iConURL: "assets/icon/trip_record.png", size: 25)),
        Expanded(
          flex: 9,
          child: Text(
            widget.tripRecord.fleetModelDesc.toString(),
            style: const TextStyle(
              color: defaultColor,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        )
      ],
    );
  }

  Widget buildFrom() {
    return Row(
      children: [
        const Expanded(
            flex: 1,
            child:
                IconCustom(iConURL: "assets/icon/location_from.png", size: 40)),
        Expanded(
          flex: 5,
          child: Text(
            dateFormat().format(DateTime.fromMicrosecondsSinceEpoch(
                    widget.tripRecord.startTime! * 1000)
                .add(const Duration(hours: -7))),
            style: styleDefaultText,
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            "| ${widget.tripRecord.startMile} KM",
            style: const TextStyle(
              color: defaultColor,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  Widget buildTo() {
    return Row(
      children: [
        const Expanded(
            flex: 1,
            child:
                IconCustom(iConURL: "assets/icon/location_to.png", size: 40)),
        Expanded(
          flex: 5,
          child: Text(
            dateFormat().format(DateTime.fromMicrosecondsSinceEpoch(
                    widget.tripRecord.endTime! * 1000)
                .add(const Duration(hours: -7))),
            style: styleDefaultText,
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            "| ${widget.tripRecord.endMile} KM",
            style: const TextStyle(
              color: defaultColor,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  Widget buildRoute() {
    return Row(
      children: [
        const Expanded(
            flex: 1,
            child: IconCustom(iConURL: "assets/icon/route.png", size: 50)),
        Expanded(
          flex: 9,
          child: Row(
            children: [
              const PaddingColum(),
              Text(
                widget.tripRecord.routeMemo.toString(),
                style: const TextStyle(
                  color: textBlack,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildTable(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text("toll_fee".tr(), style: styleDefaultText),
            ),
            Expanded(
              child: Text(
                "${widget.tripRecord.tollFee} VND",
                style: styleDefaultText,
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Row(
          children: [
            Expanded(
              child: Text("parking_fee".tr(), style: styleDefaultText),
            ),
            Expanded(
              child: Text(
                "${widget.tripRecord.parkingFee} VND",
                style: styleDefaultText,
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Row(
          children: [
            Expanded(
              child: Text("remark".tr(), style: styleDefaultText),
            ),
            const Expanded(
              child: Text(
                "",
                style: styleDefaultText,
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Row(
          children: [
            Expanded(
              child: Text("posted".tr(), style: styleDefaultText),
            ),
            Expanded(
              child: Text(
                dateFormat().format(DateTime.fromMicrosecondsSinceEpoch(
                        widget.tripRecord.createDate! * 1000)
                    .add(const Duration(hours: -7))),
                style: styleDefaultText,
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
      ],
    );
  }
}
