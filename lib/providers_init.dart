import 'package:intl/intl.dart';
import 'package:tempo/main.dart';

import 'preferences/shared_preferences.dart';

class ProvidersInit{
  static Future<void>  initLT() async {
    locale = await AppData().getLocale();
    Intl.defaultLocale = locale;
    theme = await AppData().getTheme();
  }
}