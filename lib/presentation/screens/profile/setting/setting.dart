import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fmbp/presentation/common/colors.dart';
import 'package:fmbp/presentation/widget/components/spacer_height.dart';

import '../components/title_setting.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);
  static String routeName = "setting_screen";

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  List<Language> languageList = [
    Language(locale: const Locale('en'), langName: 'English - UK'),
    Language(locale: const Locale('vi'), langName: 'VietNam - VN'),
  ];
  Language? selectedLang;
  @override
  Widget build(BuildContext context) {
    selectedLang = languageList.singleWhere((e) => e.locale == context.locale);
    return Scaffold(
      appBar: AppBar(
        title: Text("setting".tr().toUpperCase()),
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildLanguage(context),
          ],
        ),
      ),
    );
  }

  Column buildLanguage(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleSetting(keyText: "language"),
        const HeightSpacer(height: 0.01),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: bgDrawerColor, borderRadius: BorderRadius.circular(10)),
          child: DropdownButton<Language>(
            isExpanded: true,
            underline: const SizedBox(),
            items:
                languageList.map<DropdownMenuItem<Language>>((Language value) {
              return DropdownMenuItem<Language>(
                value: value,
                child: Text(
                  value.langName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              );
            }).toList(),
            value: selectedLang,
            borderRadius: BorderRadius.circular(15),
            onChanged: (newValue) {
              setState(() {
                selectedLang = newValue!;
              });
              if (newValue!.langName == 'English - UK') {
                context.setLocale(const Locale('en'));
              } else if (newValue.langName == 'VietNam - VN') {
                context.setLocale(const Locale('vi'));
              }
            },
          ),
        ),
      ],
    );
  }
}
