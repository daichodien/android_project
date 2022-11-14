import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fmbp/presentation/common/colors.dart';
import 'package:fmbp/presentation/widget/custom_card.dart';

import '../../../../models/export_model.dart';

class DetailAnnouncement extends StatelessWidget {
  const DetailAnnouncement({Key? key, required this.announcement})
      : super(key: key);

  static String routeName = "detailAnnouncement_screen";

  final Announcement announcement;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            "assets/icon/arrow_left.png",
            color: Colors.white,
            width: 30,
          ),
        ),
        title: Text("detail".tr().toUpperCase()),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.01,
            vertical: MediaQuery.of(context).size.width * 0.01),
        width: double.infinity,
        child: CardCustom(
            widget: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
          child: Column(
            children: [
              buildTitle(),
              buildContents(),
              buildBottom(),
            ],
          ),
        )),
      ),
    );
  }

  Expanded buildBottom() {
    return Expanded(
        flex: -1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(color: Colors.black),
            Text(
              "${"create_by".tr()}: ${announcement.createUserName}",
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                color: textBlack,
                fontSize: 16,
              ),
            ),
          ],
        ));
  }

  Expanded buildContents() {
    return Expanded(
        flex: 4,
        child: SingleChildScrollView(
          child: Column(
            children: [
              HtmlWidget(announcement.contents.toString()),
            ],
          ),
        ));
  }

  Expanded buildTitle() {
    DateFormat dateFormat() => DateFormat('dd/MM/yyyy, hh:mm a');
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            announcement.subject.toString().toUpperCase(),
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.2,
            ),
          ),
          Text(
            "${"type".tr()}: ${announcement.annTypeDesc.toString()}",
            style: const TextStyle(
              fontSize: 15,
              letterSpacing: 0.2,
            ),
          ),
          Text(
            // dateFormat().format(DateTime.fromMicrosecondsSinceEpoch(widget.tripRecord.endTime! * 1000).add(const Duration(hours: -7)))
            "${"create_date".tr()}: ${dateFormat().format(DateTime.fromMicrosecondsSinceEpoch(announcement.createDate! * 1000).add(const Duration(hours: -7)))}",

            style: const TextStyle(
              fontSize: 15,
              letterSpacing: 0.2,
            ),
          ),
          const Divider(color: Colors.black),
        ],
      ),
    );
  }
}
