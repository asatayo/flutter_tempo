import 'package:shared_preferences/shared_preferences.dart';
import 'package:tempo/utils/prefs.dart';

Future<bool> loadThemeBool() async {
  bool isDark = true;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('THEME')) {
    var theme = await Prefs.getPref('THEME');
     if (theme == 'LIGHT') {
      isDark = false;
    } else {
      isDark = true;
    }
  }

  return Future<bool>.value(isDark);
}