import 'package:tempo/main.dart';
import '../preferences/shared_preferences.dart';
import 'package:tempo/theme/theme.dart';
import 'package:flutter/material.dart';
class ThemeProvider extends ChangeNotifier {
   late ThemeData _selectedTheme;
  String _theme = 'DARK';
  ThemeProvider() {
    _theme = theme;
    if (_theme == 'DARK') {
      _selectedTheme = darkTheme;
      // print('darktheme');
    } else {
      _selectedTheme = lightTheme;
      // print('lighttheme');
    }
  }

  ThemeData get getTheme => _selectedTheme;

  Future<void> changeTheme(String theme) async {
    if (theme.isNotEmpty) {
      if (theme == 'DARK') {
        _selectedTheme = darkTheme;
      } else {
        _selectedTheme = lightTheme;
      }
    }
    await AppData().storeTheme(theme);

    notifyListeners();
  }

  // Future<void> _optonTheme() async {
  //   preferenses prefs = await preferenses.getInstance();
  //   _theme = prefs.getString("theme");
  // }
}
