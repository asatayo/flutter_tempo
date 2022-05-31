import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class LocaleProvider extends ChangeNotifier {
  late SharedPreferences prefs;

  Future<void> changeLocale(String locale) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setString("LOCALE", locale);
    var appLocale = Locale(locale);
    Get.updateLocale(appLocale);
   Intl.defaultLocale = locale;
    notifyListeners();
  }
}
