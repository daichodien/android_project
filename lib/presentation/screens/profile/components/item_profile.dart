import 'package:flutter/material.dart';
import 'package:fmbp/presentation/common/colors.dart';
import 'package:fmbp/presentation/widget/export_widget.dart';

class ItemProfile extends StatelessWidget {
  const ItemProfile({
    Key? key,
    required this.icon,
    required this.text,
    this.press,
  }) : super(key: key);

  final String icon;
  final String text;
  final Function? press;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
      child: CardCustom(
        widget: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: press as void Function()?,
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: IconCustom(
                    iConURL: icon,
                    size: 30,
                  ),
                ),
                // const SizedBox(width: 20),
                Expanded(
                  flex: 8,
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: textBlack,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Expanded(
                  flex: 0,
                  child: IconCustom(
                    iConURL: "assets/icon/arrow_right.png",
                    size: 25,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
