import '../preferences/shared_preferences.dart';
Future<bool> fetFutureIsHouse() async {
  bool isHouse = false;
  if (await AppData().containsKey('ISHOUSE')) {
    isHouse = await AppData().getBool('ISHOUSE');
  }
  return isHouse;
}
