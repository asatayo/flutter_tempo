import 'package:shared_preferences/shared_preferences.dart';
import 'package:tempo/utils/prefs.dart';

Future<bool> loadLanguageBool() async {
  bool isEnglish = true;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('LOCALE')) {
     var locale = await Prefs.getPref('LOCALE');
    if (locale == 'sw') {
      isEnglish = false;
    } else {
      isEnglish = true;
    }
  }
  
  return Future<bool>.value(isEnglish);
}
