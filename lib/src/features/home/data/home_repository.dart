import 'package:shared_preferences/shared_preferences.dart';
import 'package:carder/src/common/constants/constants.dart';

abstract class HomeRepository {
  Future<void> saveData({
    required String cardNumber,
    required String cardDate,
    required String cardName,
  });

  ({String number, String date, String name}) getSavedData();
}

class HomeRepositoryImpl implements HomeRepository {
  final SharedPreferences shp;
  HomeRepositoryImpl({required this.shp});

  @override
  Future<void> saveData({
    required String cardNumber,
    required String cardDate,
    required String cardName,
  }) async {
    await shp.setString(Constants.cardNumber, cardNumber);
    await shp.setString(Constants.cardDate, cardDate);
    await shp.setString(Constants.cardName, cardName);
  }

  @override
  ({String number, String date, String name}) getSavedData() {
    return (
    number: shp.getString(Constants.cardNumber) ?? '',
    date: shp.getString(Constants.cardDate) ?? '',
    name: shp.getString(Constants.cardName) ?? '',
    );
  }
}