import 'package:dio/dio.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:tempo/http/api.dart';
import 'package:tempo/models/payment_model.dart';
import 'package:tempo/preferences/shared_preferences.dart';

int refTrialCount = 0;
Future<void> sendHttpRequest(PaymentModel paymentModel, finished) async {
  var refNo = 'no_reference_number'.tr;
  var data = {
    'service': paymentModel.serviceId,
    'room': paymentModel.roomId,
    'price': paymentModel.price,
    'hours': paymentModel.duration,
    'days': paymentModel.duration,
    'house': paymentModel.houseId,
    'amount': paymentModel.amount,
    'entry_dateTime': paymentModel.entryDateTime,
    'exit_dateTime': paymentModel.exitDateTime,
    'language': paymentModel.locale,
    'fcm_token': paymentModel.fcmToken,
    "auth_key": paymentModel.authKey,
  };

  httpResponseMessage = "There was internect connection issues";

  // print(data);
// 
  var api = paymentModel.isHouse
      ? '/customer/houses/reference'
      : '/customer/services/reference';
  try {
    await httpInit();

    Response response = await dio.post(api, data: data);

    // print(response.data);

    if (response.statusCode == 200) {
      String httpRefNo = response.data['reservation'];
      if (httpRefNo != "no_reservation") {
        AppData().storeValue('NEW_REFERENCE_NUMBER', httpRefNo);
        refNo = httpRefNo;

        // print("Ëverything went fine here ");

        finished(true, refNo);
      } else {
        finished(false, refNo);
        refNo = response.data['message'];
      }
    } else {
      if (refTrialCount < 5) {
        refTrialCount++;
        sendHttpRequest(paymentModel, finished);
      } else {
        finished(false, refNo);
      }
    }
  } catch (ex) {
    if (refTrialCount < 5) {
      refTrialCount++;
      sendHttpRequest(paymentModel, finished);
    } else {
      finished(false, refNo);
    }
  }
}

int rentalRefTrialCount = 0;
Future<void> renaltReference(data, finished) async {
  var refNo = 'no_reference_number'.tr;

  httpResponseMessage = "There was internect connection issues";

  // print(data);

  var api = '/customer/auth/rental/house/payment/reference';
  try {
    await httpInit();

    Response response = await dio.post(api, data: data);

    // print(response.data);

    if (response.statusCode == 200) {
      String httpRefNo = response.data['reservation'];
      if (httpRefNo != "no_reservation") {
        AppData().storeValue('NEW_REFERENCE_NUMBER', httpRefNo);
        refNo = httpRefNo;

        // print("Ëverything went fine here ");

        finished(true, refNo);
      } else {
        finished(false, refNo);
        refNo = response.data['message'];
      }
    } else {
      if (rentalRefTrialCount < 5) {
        rentalRefTrialCount++;
        renaltReference(data, finished);
      } else {
        finished(false, refNo);
      }
    }
  } catch (ex) {
    if (rentalRefTrialCount < 5) {
      rentalRefTrialCount++;
      renaltReference(data, finished);
    } else {
      finished(false, refNo);
    }
  }
}
