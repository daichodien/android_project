// ignore_for_file: avoid_print

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fmbp/models/export_model.dart';
import 'package:fmbp/presentation/export_presentation.dart';

import '../main/main_screen.dart';

final notifiData = <InbBox>[];

class ListNotifications extends StatefulWidget {
  final InboxController _inboxController;
  const ListNotifications(this._inboxController, {Key? key}) : super(key: key);

  @override
  State<ListNotifications> createState() => _ListNotificationsState();
}

class _ListNotificationsState extends State<ListNotifications> {
  late Future<dynamic> futureNotifi;
  @override
  void initState() {
    super.initState();
    futureNotifi = widget._inboxController.getNotifi();
    // counter = widget._inboxController.getCountInbox() as ValueNotifier<int>;
    // futureNotifi = getnotification();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
      child: FutureBuilder(
          future: futureNotifi,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return notifiData.isEmpty
                  ? const EmptyWidget(text: "no_data")
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: notifiData.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              print(notifiData[index].reqId);
                            },
                            child: CardCustom(
                              widget: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildAssignDelete(index, context),
                                  buildContent(context, index)
                                ],
                              ),
                            ));
                      });
            } else if (snapshot.hasError) {
              return const EmptyWidget(text: "no_data");
            }
            return const LoadingNoBox(color: defaultColor);
          }),
    );
  }

  Widget buildContent(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: MediaQuery.of(context).size.width * 0.03),
        const IconCustom(iConURL: "assets/icon/booking.png", size: 40),
        SizedBox(width: MediaQuery.of(context).size.width * 0.03),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.76,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.02),
                child: Text(
                  notifiData[index].requestMessage!.tr().toString(),
                  style: const TextStyle(
                    color: textBlack,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                notifiData[index].requestDate!.tr().toString(),
                style: TextStyle(color: Colors.grey[800]),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            ],
          ),
        )
      ],
    );
  }

  Row buildAssignDelete(int index, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
          child: Center(
            child: Text(
              notifiData[index].requestTitle!.tr().toString(),
              style: const TextStyle(
                  fontSize: 17,
                  color: defaultColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          height: 40,
          child: IconButton(
            icon: const IconCustom(iConURL: "assets/icon/delete.png", size: 25),
            onPressed: () {
              final id = int.parse(notifiData[index].reqId.toString());
              // globalInbox.setId = notifiData[index].reqId.toString();
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (index) {
                    return AreYouSure(
                      text: "are_you_sure_delete".tr(),
                      pressCanel: () {
                        Navigator.pop(context, false);
                      },
                      pressOK: () {
                        Navigator.pop(context, true);
                        // Navigator.of(context)
                        //     .pop(widget._inboxController.getCountInbox());
                      },
                    );
                  }).then((exit) {
                if (exit == null) return;
                if (exit) {
                  widget._inboxController.deleteNotifications(id);

                  setState(() {
                    notifiData.removeAt(index);
                    widget._inboxController.getNotifi();
                    widget._inboxController.getCountInbox();
                    counter.value = widget._inboxController.getCountInbox();
                    // getnotification();
                  });

                  return;
                } else {}
                return;
              });
            },
          ),
        ),
      ],
    );
  }
}
