import 'package:carder/src/common/widgets/app.dart';
import 'package:carder/src/common/widgets/app_scope.dart';
import 'package:carder/src/common/widgets/intialize_app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dependency = await InitializeApp().initialize();
  runApp(AppScope(dependency: dependency,
  child: const MyApp()));

}
