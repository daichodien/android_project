import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fmbp/presentation/export_presentation.dart';

class BodyHelp extends StatelessWidget {
  const BodyHelp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 0,
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
            child: CardCustom(
                widget: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeightSpacer(height: 0.02),
                  Text(
                    "contact_us".tr(),
                    style: _textStyle(),
                  ),
                  Divider(
                    color: Colors.grey[700],
                  ),
                  const HeightSpacer(height: 0.02),
                  Text(
                    "Project Team",
                    style: _textStyle(),
                  ),
                  const HeightSpacer(height: 0.02),
                  const ItemContact(
                    name: "Nguyễn Thị Xuân",
                    numberPhone: "09.8362.1782",
                  ),
                  const ItemContact(
                    name: "Q.T Hồng Phúc",
                    numberPhone: "07.6814.8936",
                  ),
                  const ItemContact(
                    name: "Lê Xuân Khánh",
                    numberPhone: "09.1430.5970",
                  )
                ],
              ),
            )),
          ),
        ),
      ],
    );
  }

  TextStyle _textStyle() {
    return const TextStyle(
      fontSize: 17,
    );
  }
}

class ItemContact extends StatelessWidget {
  const ItemContact({
    Key? key,
    required this.name,
    required this.numberPhone,
  }) : super(key: key);

  final String name;
  final String numberPhone;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width * 0.01),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                const Expanded(
                    flex: 1,
                    child:
                        IconCustom(iConURL: "assets/icon/phone.png", size: 25)),
                Expanded(
                  flex: 4,
                  child: Text(
                    numberPhone,
                    style: styleDefaultText,
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: Text(
            name,
            style: styleDefaultText,
          ))
        ],
      ),
    );
  }
}
