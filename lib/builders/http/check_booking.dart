import 'package:dio/dio.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:tempo/fireabase.dart';
import 'package:tempo/models/payment_model.dart';
import 'package:tempo/preferences/shared_preferences.dart';

Future<String> sendCheckHttpRequest(PaymentModel paymentModel) async {
  String? refNo = 'no_reference_number'.tr;
  String locale = await AppData().getLocale();

  if (await AppData().containsKey('NEW_REFERENCE_NUMBER')) {
    refNo = await AppData().getString("NEW_REFERENCE_NUMBER");
  } else {
    String? fcmToken = await requestFbToken();
    var data = {
      'service': paymentModel.serviceId,
      'room': paymentModel.roomId,
      'price': paymentModel.price,
      'hours': paymentModel.duration,
      'days': paymentModel.duration,
      'quantity': paymentModel.roomsCount,
      'cooperate_number': paymentModel.cooperateNumber,
      'house': paymentModel.houseId,
      'amount': paymentModel.amount,
      'entry_dateTime': paymentModel.entryDateTime,
      'exit_dateTime': paymentModel.exitDateTime,
      'language': locale,
      'fcm_token': fcmToken,
      "auth_key": "dGVtcG9ib29raW5nOmFwaV9BdXRoMUAqJjZSVEQ=",
    };
    // print(data);
    try {
      var dioOptions = BaseOptions(
        baseUrl: 'https://tempoapplication.com/api',
        connectTimeout: 16000,
        receiveTimeout: 16000,
        contentType: Headers.formUrlEncodedContentType,
      );
      Dio dio = Dio(dioOptions);
      Response response = await dio.post(
          paymentModel.isHouse
              ? '/cooperate/house/booking'
              : '/cooperate/service/booking',
          data: data);

      if (response.statusCode == 200) {
        var httpRefNo = response.data['reservation'];
        // print(response.data);
        if (httpRefNo != "no_reservation") {
          AppData().storeValue('NEW_REFERENCE_NUMBER', httpRefNo);
          refNo = httpRefNo;
        } else {
          refNo = response.data['message'];
        }
      }
    } on DioError {
      refNo = "connection_error".tr;
    }
  }
  return Future<String>.value(refNo);
}
