
import 'dart:io';

import 'package:tempo/preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

// ignore: constant_identifier_names
const String LOGIN_URL = '/customer/login';
// ignore: constant_identifier_names
const String REGISTER_URL = '/customer/register';
// ignore: constant_identifier_names
const String OTP_VERIFICATION_URL = '/customer/otp-verification';
// ignore: constant_identifier_names
const String RESEND_OTP_URL = '/customer/otp-resend';
// ignore: constant_identifier_names
const String CHANGE_PASSWORD_URL = '/customer/auth/change-password';
// ignore: constant_identifier_names
const String UPDATE_PROFILE_URL = '/customer/auth/update-profile';

String httpResponseMessage = "Internet connection issues";

const String baseServer =  'https://api.tempoapplication.com/api';
const String baseServerFile =  'https://api.tempoapplication.com/';  

late Dio dio;
late Response response;
bool status = false;

Future<void> httpInit() async {
  var authToken = await AppData().authToken();
    var dioOptions = BaseOptions(
        baseUrl: baseServer,
        connectTimeout: 500000,
        receiveTimeout: 500000,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $authToken"
        });
   dio = Dio(dioOptions);
}