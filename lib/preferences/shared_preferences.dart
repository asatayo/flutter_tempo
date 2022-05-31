import 'package:shared_preferences/shared_preferences.dart';

class AppData {
  late SharedPreferences sharedPref;
  Future<void> initPref() async {
    sharedPref = await SharedPreferences.getInstance();
  }

  Future<void> storeValue(String key, dynamic value) async {
    await initPref();
    if (value is int) {
      sharedPref.setInt(key, value);
    } else if (value is String) {
      sharedPref.setString(key, value);
    } else if (value is bool) {
      sharedPref.setBool(key, value);
    } else {
      sharedPref.setString(key, value);
    }
  }

  Future<void> storeFCM(String fcm) async {
    await initPref();
    sharedPref.setString("fcmToken", fcm);
  }

  Future<void> storeTheme(String value) async {
    await initPref();
    sharedPref.setString('THEME', value);
  }

  Future<void> storeLocale(String value) async {
    await initPref();
    sharedPref.setString('LOCALE', value);
  }

  Future<bool> containsKey(String key) async {
    await initPref();
    bool hasKey = sharedPref.containsKey(key);
    return Future.value(hasKey);
  }

  Future<String?> getString(String key) async {
    await initPref();
    String value = " ";

    if (sharedPref.containsKey(key)) {
      value = sharedPref.getString(key)!;
    }
    return value;
  }

  Future<int> getInt(String key) async {
    await initPref();
    int value = 0;
    if (sharedPref.containsKey(key)) {
      value = sharedPref.getInt(key)!;
    }

    return value;
  }

  Future<double> getDouble(String key) async {
    await initPref();
    double value = 0;
    if (sharedPref.containsKey(key)) {
      value = sharedPref.getDouble(key)!;
    }
    return value;
  }

  Future<bool> getBool(String key) async {
    await initPref();
    bool value = false;
    if (sharedPref.containsKey(key)) {
      value = sharedPref.getBool(key)!;
    }
    return value;
  }

  Future<String> getLocale() async {
    await initPref();
    String value = sharedPref.getString('LOCALE') ?? 'en';
    return value;
  }

  Future<String> getTheme() async {
    await initPref();
    String? value = sharedPref.getString('THEME') ?? 'DARK';
    if (sharedPref.containsKey('THEME')) {
      value = sharedPref.getString('THEME') ?? 'DARK';
    }
    return value;
  }

  

  Future<String?> authToken() async {
    await initPref();
    String? value;
    if (sharedPref.containsKey('authToken')) {
       value = sharedPref.getString('authToken');
    }

    return value;
  }

  Future<bool> removeData(String key) async {
    await initPref();
    return sharedPref.remove(key);
  }
}
