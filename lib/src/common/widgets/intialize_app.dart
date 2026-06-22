import 'package:carder/src/common/dependency/appdependency.dart';

import 'package:shared_preferences/shared_preferences.dart';

class InitializeApp {
  Future<AppDependency> initialize() async {
    final shp = await SharedPreferences.getInstance();
    // NfcAvailability isAvailable = await NfcManager.instance.checkAvailability();
    // if ( isAvailable == NfcAvailability.unsupported) {
    //   shp.setBool(Constants.checkNfc, false);
    // }else{
    //   shp.setBool(Constants.checkNfc, true);
    // }
    return AppDependency(shp);
  }
}
