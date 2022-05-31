import 'dart:ui';

import '../preferences/shared_preferences.dart';
import 'package:get/get.dart';

Future<void> changeLocale(String locale, bool shouldUpdate) async {
  await AppData().storeLocale(locale);
  if (shouldUpdate) {
    var appLocale = Locale(locale);
    Get.updateLocale(appLocale);
  }
}
