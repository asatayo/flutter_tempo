import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static void saveData(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is int) {
      prefs.setInt(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else {
     prefs.setString(key, value);
    }
  }

  static Future<dynamic> readData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    dynamic obj = prefs.get(key);
    return obj;
  }

  static Future<bool> deleteData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  static void storePref(String key, String value) async {
    final preferenses = await SharedPreferences.getInstance();
    preferenses.setString(key, value);
  }

  static void storeIntPref(String key, int value) async {
    final preferenses = await SharedPreferences.getInstance();
    preferenses.setInt(key, value);
  }
  

  static getPref(String key) async {
    final preferenses = await SharedPreferences.getInstance();
    return preferenses.getString(key);
  }

  static getIntPref(String key) async {
    final preferenses = await SharedPreferences.getInstance();
    return preferenses.getInt(key) ?? 0;
  }
  static getBoolPref(String key) async {
    final preferenses = await SharedPreferences.getInstance();
    return preferenses.getBool(key) ?? false;
  }

  static Future<String> getToken() async {
    // final preferenses = await preferenses.getInstance();
    String token =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5NDYzZjYwOS04YzcyLTQ0YmUtOWYxZi1kMmI4YTU2NGY0MWIiLCJqdGkiOiJlYTY4ZDQ5OWRlNzM1NzYzZDIwMmE5ZWY1OWZkNGU0ZDliYzhjMzRkYjU3ZmNhNDA4ZGZkNDc2ZGY5Mjc1NTkyMmJjMzExMTYyNzQ1Y2QxMiIsImlhdCI6MTYzMTU3MzExMy40MjQ0ODcsIm5iZiI6MTYzMTU3MzExMy40MjQ0OTUsImV4cCI6MTY2MzEwOTExMy4zNzExNSwic3ViIjoiMSIsInNjb3BlcyI6W119.i0oQYfm55d4QZf9PKHs5de0hbWI2XFJb0FyeMqNDLpUfVeRNesH2AYoh-ETN76KvfQ8sMjZygFKD8-0tK3VBYwrXgz7UMVxlYdpZ3C--jgQGuAz15k43Vomcl65GqHguZkS-FBAtjelNSKtOIFUK1kZjw1g-8r2FhAGGn9vAwlBB9HvUNuFBjZs8Ra-xmZnuDUo88JKH9yPPYgIWWFiIaojD6eLZ_xugE-kD8DJhPi3LkVFBhOodWbdIFSaVecCrcBhfuCXr9Xkk0aURnUy4vU6FO3kj33Khh27wnwCYyTDPG1z9jShaFMtjPfTh02dldiPH81Ru4Jp40Gshj_JwVh3X2mDEw8IdRxVOPD7ayzZpi_xHIvCc-s-7qjNesRlfTOmQMX4z2uZaM8cJpi63j-2kwRjaUXkw9p2egzG2l-6SBYjzOqQ8SZHl3TO44zvGC75a-Pn1zJRfiBMtlRVTqGWY6P0DIy-Ha4_zftO2di4EUD_o6VziEozzF8kRBhBdqBS_2hmiQmIi7B6-Y7q_bJBicJ6lIS_VL6pjf6-ToOaNsqgSLJGlkZdglz-cWlWrC2JaTCMawxtiONNeqtefF-hIyFiOr3v9anPy5l6YX-kfXQnMd8maqHIwzJTedpP08B79p02GEH3OW0pJJbWUcSvbjOT1dPoKM5E7CmH9ucs';
    return token;
    // return preferenses.getString('token') ?? token;
  }

  static  getLocale() async {
    var locale = 'en';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('locale')) {
      locale = prefs.getString("locale") ?? 'en';
    }
    return locale;
  }
}
