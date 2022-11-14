import 'package:flutter/material.dart';

import '../../../common/export_common.dart';

class Avt extends StatelessWidget {
  const Avt({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          padding: const EdgeInsets.all(0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          )),
      onPressed: () {},
      child: SizedBox(
        height: 115,
        width: 115,
        child: Stack(
          fit: StackFit.expand,
          children: const [
            CircleAvatar(
              backgroundImage: AssetImage("assets/images/avt.png"),
              backgroundColor: defaultColor,
            ),
            // ElevatedButton(onPressed: () {}, child: Icon(Icons.camera_alt)),
            // Positioned(
            //   width: 40,
            //   height: 40,
            //   right: 0,
            //   bottom: 0,
            //   child: Container(
            //     padding: const EdgeInsets.all(5),
            //     decoration: const BoxDecoration(
            //         color: secondColor,
            //         borderRadius: BorderRadius.all(Radius.circular(20))),
            //     child: const Icon(
            //       Icons.camera_alt,
            //       color: Colors.white,
            //     ),
            //   ),
            // ), // Positioned(
          ],
        ),
      ),
    );
  }
}
