import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../common/colors.dart';
import '../../../widget/empty.dart';

class MapWithMarker extends StatelessWidget {
  const MapWithMarker({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: textBlack,
      primary: textBlack,
      // minimumSize: Size(100, 36),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );
    return TextButton.icon(
        style: raisedButtonStyle,
        onPressed: () => showDialog(
              context: context,
              builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: Text("map".tr()),
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
                  ),
                  body: EmptyWidget(text: "update".tr())),
            ),
        icon: Image.asset(
          "assets/icon/ggmap.png",
          width: MediaQuery.of(context).size.height * 0.05,
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        label: Text(
          "map_with_marker".tr(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ));
  }
}
