import 'dart:async';
import 'package:dio/dio.dart';
import 'package:tempo/http/api.dart';

const String exceededType = "EXCEEDED";
const String emptyType = "EMPTY";
const String successType = "SUCCESS";
const String ussdSuccess = "SUCCESS";
const String ussdFail = "FAIL";
int checkCount = 0;

Future<void> initiatePayments(var data, finishStatus) async {
  httpResponseMessage = "There was internect connection issues";
  String ussdStatus = "FAILED";
  var api = '/v1/payments/selcom/pay/ussd';
  print(api);
  try {
    await httpInit();
    response = await dio.post(api, data: data);
    print(response.data);
    if (response.statusCode == 200) {
      // type = response.data['type'];
      String message = response.data['message'];
      ussdStatus = response.data['ussd'];
      httpResponseMessage = message;
      status = response.data['success'];
    }

    finishStatus(status, ussdStatus);
    // ignore: empty_catches
  } catch (e) {
    print(e);
  }
}

Future<void> httpCheckout(var data, finishChechout) async {
  httpResponseMessage = "There was internect connection issues";
  bool status = false;
  String? url;
  var api = '/v1/payments/selcom/pay/card';
  try {
    await httpInit();
    Response response = await dio.post(api, data: data);

    // print(response.data);
    if (response.statusCode == 200) {
      String message = response.data['message'];
      url = response.data['url'];
      httpResponseMessage = message;
      status = response.data['success'];
    }

    finishChechout(status, url);
    // ignore: empty_catches
  } catch (e) {
    // print(e);
  }
}

Future<void> checkStatus(var data, isPaymentDone) async {
  String message = "UNPAID";
  String? reference;
//  print('Checking status');
  var api = '/v1/payments/selcom/status';
  try {
    await httpInit();

    // print(data);
    Response response = await dio.post(api, data: data);

     print(response.data);

    if (response.statusCode == 200) {
      message = response.data['message'];
      reference = response.data['reference'];
    }

    if (message == "PAID") {
      isPaymentDone(true, message, reference);
    } else {
      if (checkCount < 500) {
        Timer(const Duration(seconds: 5), () async {
          checkCount++;
          // print('re-loading status ' + checkCount.toString());
          await checkStatus(data, isPaymentDone);
        });
      } else {
        // print("Checked but not paid");
        checkCount = 0;
        isPaymentDone(false, message, reference);
      }
    }
    // ignore: empty_catches
  } catch (e) {
    checkCount++;
    await checkStatus(data, isPaymentDone);
    // print(e);
  }
  // isLoadingHttp = false;
}
