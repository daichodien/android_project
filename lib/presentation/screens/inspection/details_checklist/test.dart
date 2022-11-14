// import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fmbp/presentation/export_presentation.dart';

class TestABC extends StatefulWidget {
  const TestABC({Key? key}) : super(key: key);

  @override
  State<TestABC> createState() => _TestABCState();
}

class _TestABCState extends State<TestABC> {
  InAppWebViewController? webView;
  String url = "";

  double progress = 0;
  Future<bool> _goBack(BuildContext context) async {
    if (await webView!.canGoBack()) {
      webView!.goBack();
      return Future.value(false);
    } else {
      // CoolAlert.show(
      //     context: context,
      //     type: CoolAlertType.confirm,
      //     confirmBtnColor: Colors.red,
      //     text: "Exit",
      //     onConfirmBtnTap: (){
      //       exit(0);
      //     }
      // );
      return Future.value(true);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String getUrl() {
    var url =
        "https://fmbp.enterprise.vn:8108/admin/support/checklistinspection";
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _goBack(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Detail"),
        ),
        body: Column(
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
                decoration:
                    BoxDecoration(border: Border.all(color: defaultColor)),
                child: InAppWebView(
                  // initialUrlRequest: URLRequest(url: Uri.parse(getUrl())),
                  initialData: InAppWebViewInitialData(
                    data: """
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    </head>
    <body>
        <h1>JavaScript Handlers</h1>
        <script>
            window.addEventListener("flutterInAppWebViewPlatformReady", function(event) {
                window.flutter_inappwebview.callHandler('handlerFoo')
                  .then(function(result) {
                    // print to the console the data coming
                    // from the Flutter side.
                    console.log(JSON.stringify(result));
                    
                    window.flutter_inappwebview
                      .callHandler('handlerFooWithArgs', 1, true, ['bar', 5], {foo: 'baz'}, result);
                });
            });
        </script>
    </body>
</html>
                      """,
                  ),

                  // onJsAlert: (controller, jsAlertRequest) {

                  // },

                  initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(),
                      ios: IOSInAppWebViewOptions(),
                      android: AndroidInAppWebViewOptions(
                          useHybridComposition: true)),
                  onWebViewCreated: (InAppWebViewController controller) {
                    //

                    controller.addJavaScriptHandler(
                        handlerName: 'handlerFoo',
                        callback: (args) {
                          // return data to the JavaScript side!
                          return {'bar': 'bar_value', 'baz': 'baz_value'};
                        });

                    controller.addJavaScriptHandler(
                        handlerName: 'handlerFooWithArgs',
                        callback: (args) {
                          print("args: $args");
                          // it will print: [1, true, [bar, 5], {foo: baz}, {bar: bar_value, baz: baz_value}]
                        });

                    //
                    webView = controller;
                  },
                  onLoadStart: (controller, url) {
                    setState(() {
                      this.url = url?.toString() ?? '';
                    });
                  },
                  onLoadStop: (controller, url) async {
//

//
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
        ),
      ),
    );
  }
}
