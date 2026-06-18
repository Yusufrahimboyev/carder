
import 'package:carder/src/common/style/app_theme.dart';

import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home:Scaffold(),
      supportedLocales: [Locale('en'), Locale('uz'), Locale('ru')],
      localizationsDelegates: [
       // S.delegate,
        // GlobalMaterialLocalizations.delegate,
        // GlobalWidgetsLocalizations.delegate,
        // GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
