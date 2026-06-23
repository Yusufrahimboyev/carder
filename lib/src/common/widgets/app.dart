import 'package:carder/src/common/l10n/generated/l10n.dart';
import 'package:carder/src/common/style/app_theme.dart';
import 'package:carder/src/common/utils/context_extension.dart';
import 'package:carder/src/features/home/data/home_repository.dart';
import 'package:carder/src/features/home/presentation/bloc/homebloc.dart';
import 'package:carder/src/features/home/presentation/screens/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => HomeBloc(
          repository: HomeRepositoryImpl(shp: context.dependency.shp),
        )..add(LoadCardEvent()),
        child: HomeScreen(),
      ),
      locale: const Locale('uz'),
      supportedLocales: [Locale('en'), Locale('uz'), Locale('ru')],
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
