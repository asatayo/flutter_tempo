import 'package:shared_preferences/shared_preferences.dart';
import 'package:tempo/utils/prefs.dart';

Future<bool> isAuthenticated() async {
  bool isAuthenticated = false;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('isAuthenticated')) {
    isAuthenticated = await Prefs.getBoolPref('isAuthenticated');
  }
  return Future<bool>.value(isAuthenticated);
}
