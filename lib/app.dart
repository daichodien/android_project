import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fmbp/presentation/screens/auth/login/index.dart';

import 'aplications/routes/route.dart';
import 'presentation/export_presentation.dart';

class FMBP extends StatefulWidget {
  const FMBP({Key? key}) : super(key: key);

  @override
  State<FMBP> createState() => _FMBPState();
}

class _FMBPState extends State<FMBP> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: LoginScreen.routeName,
      routes: routes,
    );
  }
}
