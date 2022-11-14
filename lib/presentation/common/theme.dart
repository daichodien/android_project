import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData theme() {
  return ThemeData(
    //Font chữ cho toàn bộ source
    fontFamily: "Lato",
    textTheme: textTheme(),
    // brightness: Brightness.dark,  // Dùng cho dark theme
    appBarTheme: appBarTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    bottomNavigationBarTheme: bottomNavigationBarThemeData(),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    
    backgroundColor: defaultColor,
    elevation: 0,
    titleTextStyle: textStyleAppBar(),
    actionsIconTheme: null,
    centerTitle: true,
  );
}

TextStyle textStyleAppBar() {
  return const TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
}

BottomNavigationBarThemeData bottomNavigationBarThemeData() {
  return BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    showUnselectedLabels: false,
    selectedIconTheme: const IconThemeData(color: defaultColor),
    selectedLabelStyle: selectedLabelStyle(),
  );
}

TextStyle selectedLabelStyle() {
  return const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
  );
}

InputDecorationTheme inputDecorationTheme() {
  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: Colors.black),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 25,
      vertical: 15,
    ),
    enabledBorder: outlineInputBorder,
    disabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,

    errorStyle: const TextStyle(
      height: 0,
    ), //Dùng để khi eror nhưng vẫn giữ nguyên layout
  );
}

TextTheme textTheme() {
  return const TextTheme(
      bodyText1: TextStyle(
    fontSize: 18,
  ));
}
