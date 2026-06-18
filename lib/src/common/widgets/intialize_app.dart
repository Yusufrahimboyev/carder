import 'package:carder/src/common/dependency/appdependency.dart';


class InitializeApp {
  Future<AppDependency> initialize() async {
    return AppDependency();
  }
}
