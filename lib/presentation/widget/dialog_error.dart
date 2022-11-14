import 'package:flutter/material.dart';
import 'package:fmbp/presentation/widget/icon_custom.dart';

class DialogError extends StatelessWidget {
  const DialogError({
    Key? key,
    this.widget,
  }) : super(key: key);

  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          const Positioned(
            top: -30,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.red,
              child:
                  IconCustom(iConURL: "assets/icon/error_dialog.png", size: 50),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height -
                (MediaQuery.of(context).size.width * 1.1),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.height * 0.04, //left
                MediaQuery.of(context).size.height * 0.08,
                MediaQuery.of(context).size.height * 0.04,
                MediaQuery.of(context).size.height * 0.02,
              ),
              child: Center(
                child: widget,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
