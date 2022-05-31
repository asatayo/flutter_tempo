import 'dart:core';
import 'package:tempo/http/api.dart';
import 'package:tempo/preferences/shared_preferences.dart';

Future<bool> loginAuthentication(data) async {
  try {
    await httpInit();
    response = await dio.post(LOGIN_URL, data: data);
    if (response.statusCode == 200) {
      String message = response.data['message'];
      httpResponseMessage = message;
      status = response.data['success'];
      if (status) {
        String firstName = response.data['user']['first_name'];
        String lastName = response.data['user']['last_name'];
        String profile = baseServerFile + response.data['user']['profile'];
        String username = response.data['user']['username'];
        String phone = response.data['user']['phone'];
        String authToken = response.data['token'];

        await AppData().storeValue('isAuthenticated', true);
        await AppData().storeValue('authToken', authToken);
        await AppData().storeValue('profile', profile);
        await AppData().storeValue('username', username);
        await AppData().storeValue('phone', phone);
        await AppData().storeValue('first_name', firstName);
        await AppData().storeValue('last_name', lastName);
      }
    }
    // ignore: empty_catches
  } catch (e) {
    // print(e);
  }
  // isLoadingHttp = false;
  return Future.value(status);
}

Future<bool> signUpAuthentication(data) async {
  await httpInit();

  try {
    response = await dio.post(REGISTER_URL, data: data);
    // print(response.data);
    if (response.statusCode == 200) {
      String message = response.data['message'];
      httpResponseMessage = message;
      status = response.data['success'];
    }
    // ignore: empty_catches
  } catch (e) {
    // print(e);
  }
  // isLoadingHttp = false;
  return Future.value(status);
}

Future<bool> isValidOTP(data) async {
  try {
    await httpInit();

    response = await dio.post(OTP_VERIFICATION_URL, data: data);
    if (response.statusCode == 200) {
      httpResponseMessage = response.data['message'];
      status = response.data['success'];
      if (status) {
        String firstName = response.data['user']['first_name'];
        String lastName = response.data['user']['last_name'];
        String profile = baseServerFile + response.data['user']['profile'];
        String username = response.data['user']['username'];
        String phone = response.data['user']['phone'];
        String authToken = response.data['token'];
        await AppData().storeValue('isAuthenticated', true);
        await AppData().storeValue('authToken', authToken);
        await AppData().storeValue('profile', profile);
        await AppData().storeValue('username', username);
        await AppData().storeValue('phone', phone);
        await AppData().storeValue('first_name', firstName);
        await AppData().storeValue('last_name', lastName);
      }
    }

    // ignore: empty_catches
  } catch (e) {}
  // isLoadingHttp = false;
  return Future.value(status);
}

Future<bool> resendOTP(data) async {
  try {
    await httpInit();

    response = await dio.post(RESEND_OTP_URL, data: data);

    if (response.statusCode == 200) {
      httpResponseMessage = response.data['message'];
    }
    // ignore: empty_catches
  } catch (e) {
    //  print(e);

  }
  // isLoadingHttp = false;
  return Future.value(true);
}

Future<bool> changeMyPassword(data) async {
  try {
    await httpInit();

    response = await dio.post(CHANGE_PASSWORD_URL, data: data);

    if (response.statusCode == 200) {
      httpResponseMessage = response.data['message'];
      status = response.data['success'];
    }
  } catch (e) {
    // print(e);
  }
  // isLoadingHttp = false;
  return Future.value(status);
}

Future<bool> updateProfile(data) async {
  try {
    await httpInit();
    response = await dio.post(UPDATE_PROFILE_URL, data: data);
    if (response.statusCode == 200) {
      httpResponseMessage = response.data['message'];
      status = response.data['success'];
      if (status) {
        String firstName = response.data['user']['first_name'];
        String lastName = response.data['user']['last_name'];
        String profile = baseServerFile + response.data['user']['profile'];
        String username = response.data['user']['username'];
        String phone = response.data['user']['phone'];
        await AppData().storeValue('profile', profile);
        await AppData().storeValue('username', username);
        await AppData().storeValue('phone', phone);
        await AppData().storeValue('first_name', firstName);
        await AppData().storeValue('last_name', lastName);
      }
    }

    // ignore: empty_catches
  } catch (e) {
    // print(e);
  }
  // isLoadingHttp = false;
  return Future.value(status);
}
