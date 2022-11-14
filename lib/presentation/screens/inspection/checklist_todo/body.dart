import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../../data/dtos/type_check.dart';
import '../../../../data/global/global_inspection.dart';
import '../../../../data/global/profile_driver.dart';
import '../../../../data/global/user.dart';
import '../../../common/colors.dart';

class BodyCheckTodo extends StatefulWidget {
  const BodyCheckTodo({Key? key}) : super(key: key);

  @override
  State<BodyCheckTodo> createState() => _BodyCheckTodoState();
}

class _BodyCheckTodoState extends State<BodyCheckTodo> {
  InAppWebViewController? webView;
  String url = "";

  double progress = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String getUrl() {
    var id = globalUser.getId;
    var driverId = globalDriver.getStaffID;
    var fleetDesc = globalDriver.getFleetDesc;
    var type = TypeCheck.Driver;
    Timer(const Duration(seconds: 10), () => globalInspection.setBookNo = "");
    var bookNo = globalInspection.getBookNo;
    var url =
        "https://fmbp.enterprise.vn:8108/inspection?bookno=$bookNo&driverid=$driverId&equimentcode=$fleetDesc&userid=$id&type=$type";
    print(url);
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            child: progress < 1.0
                ? LinearProgressIndicator(
                    value: progress,
                    color: defaultColor,
                  )
                : Container()),
        Expanded(
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: defaultColor)),
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse(getUrl())),
              initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(),
                  ios: IOSInAppWebViewOptions(),
                  android:
                      AndroidInAppWebViewOptions(useHybridComposition: true)),
              onWebViewCreated: (InAppWebViewController controller) {
                webView = controller;
              },
              onLoadStart: (controller, url) {
                setState(() {
                  this.url = url?.toString() ?? '';
                });
              },
              onLoadStop: (controller, url) async {
                setState(() {
                  this.url = url?.toString() ?? '';
                });
              },
              onProgressChanged: (controller, progress) {
                setState(() {
                  this.progress = progress / 100;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
