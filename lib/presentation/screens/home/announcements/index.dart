import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fmbp/presentation/export_presentation.dart';

import '../../../../models/export_model.dart';
import 'detail_announcements.dart';

final announcement = <Announcement>[];

class AnnouncementsBox extends StatefulWidget {
  const AnnouncementsBox({Key? key}) : super(key: key);

  @override
  State<AnnouncementsBox> createState() => _AnnouncementsBoxState();
}

class _AnnouncementsBoxState extends State<AnnouncementsBox> {
  final LoginController _loginController = LoginController();
  late Future<dynamic> futureAnn;
  @override
  void initState() {
    super.initState();
    futureAnn = _loginController.getAnnouncements();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.03,
        vertical: MediaQuery.of(context).size.width * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "announcements".tr(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: const BoxDecoration(
              color: secondColor,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Padding(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.2,
                child: FutureBuilder(
                  future: futureAnn,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return announcement.isEmpty
                          ? Center(
                              child: Text(
                                "no_data".tr(),
                                style: const TextStyle(
                                  color: textWhite,
                                  fontSize: sizeTextDefault,
                                ),
                              ),
                            )
                          : ListView.builder(
                              physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              itemCount: announcement.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  color: bgDrawerColor,
                                  child: ListTile(
                                    title: buildTitle(index),
                                    // subtitle: buildSubTitle(index),
                                    subtitle: buildSubTitle(index),
                                    leading: const IconCustom(
                                      iConURL: "assets/icon/new_button.gif",
                                      size: 50,
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailAnnouncement(
                                                  announcement:
                                                      announcement[index]),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                    }
                    return const Center(
                        child: LoadingNoBox(color: Colors.white));
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSubTitle(int index) {
    return Text(
      announcement[index].annTypeDesc.toString(),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: styleHintInput,
    );
  }

  Widget buildTitle(int index) {
    return Text(
      announcement[index].subject.toString().toUpperCase(),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: styleLabelInput,
    );
  }
}
