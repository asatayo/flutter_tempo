import 'package:tempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeData _selectedTheme;
  late SharedPreferences prefs;
  final String theme;
  ThemeProvider({ required this.theme}) {
    if (theme.isNotEmpty) {
      if (theme == 'DARK') {
        _selectedTheme = darkTheme;
      } else {
        _selectedTheme = lightTheme;
      }
    }
  }

  ThemeData get getTheme => _selectedTheme;

  Future<void> changeTheme(String s) async {
    prefs = await SharedPreferences.getInstance();
    if (_selectedTheme == darkTheme) {
      _selectedTheme = lightTheme;

      await prefs.setString("THEME", 'LIGHT');
    } else {
      _selectedTheme = darkTheme;
      await prefs.setString("THEME", 'DARK');
    }
    // SystemChrome.setEnabledSystemUIOverlays(SystemOver.manual,
    //     overlays: SystemUiOverlay.values);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor:
    //         theme == "dark" ?  Color(0xFF020202) :  Color(0xFFFFFFFF),
    //     statusBarIconBrightness:
    //         theme == "dark" ? Brightness.light : Brightness.dark));




    notifyListeners();
  }
//   Future<void> setTheme(value, c) async {

//     preferenses.getInstance().then((prefs) {
//       prefs.setString("theme", c).then((val) {
//
//         ));
//       });
//     });
//     prefs = await preferenses.getInstance();

//     if (_selectedTheme == darkTheme) {
//       _selectedTheme = lightTheme;
//       await prefs.setBool("isDark", false);
//     } else {
//       _selectedTheme = darkTheme;
//       await prefs.setBool("isDark", true);
//     }
// //notifying all the listeners(consumers) about the change.
//     // notifyListeners();
//     notifyListeners();
//   }
}
