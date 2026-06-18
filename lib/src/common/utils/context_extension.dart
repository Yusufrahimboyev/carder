import 'package:carder/src/common/dependency/appdependency.dart';

import 'package:carder/src/common/widgets/app_scope.dart';
import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  AppDependency get dependencies =>
      findAncestorStateOfType<AppScopeState>()!.dependency;
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  //S get localizations => S.of(this);
  AppDependency get dependency =>
      findAncestorStateOfType<AppScopeState>()!.dependency;
}
