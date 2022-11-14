import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fmbp/presentation/export_presentation.dart';

class ItemAccount extends StatefulWidget {
  const ItemAccount({
    Key? key,
    this.controller,
    required this.edit,
    required this.iconUrl,
    required this.content,
  }) : super(key: key);

  final TextEditingController? controller;
  final bool edit;
  final String content;
  final String iconUrl;

  @override
  State<ItemAccount> createState() => _ItemAccountState();
}

class _ItemAccountState extends State<ItemAccount> {
  // @override
  // void init() {
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width * 0.015),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.content.tr(),
            style: styleText(),
          ),
          const HeightSpacer(height: 0.0080),
          TextFormField(
            controller: widget.controller,
            enabled: widget.edit,
            style: styleText2(),
            // autofocus: false,
            decoration: inputDecoration(),
          ),
        ],
      ),
    );
  }

  InputDecoration inputDecoration() {
    return InputDecoration(
      disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      fillColor: bgDrawerColor,
      filled: true,
      hintText: widget.content.tr(),
      // icon: IconCustom(iConURL: widget.iconUrl, size: 30),
      prefixIcon: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
        child: IconCustom(iConURL: widget.iconUrl, size: 25),
      ),
    );
  }

  TextStyle styleText() {
    return const TextStyle(
      fontWeight: FontWeight.bold,
      wordSpacing: 2,
      letterSpacing: 0.2,
      color: textBlack,
    );
  }

  TextStyle styleText2() {
    return const TextStyle(
      fontWeight: FontWeight.w600,
      wordSpacing: 2,
      letterSpacing: 0.5,
      color: textDarkBlue,
    );
  }
}
