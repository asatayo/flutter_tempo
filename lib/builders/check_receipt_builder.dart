import 'package:dio/dio.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../preferences/shared_preferences.dart';
import 'package:tempo/utils/prefs.dart';

Future<String> getPaymentReceipt(String reference, bool isHouse) async {
  String receiptNumber = 'not_paid'.tr;
  String locale = await Prefs.getLocale();

  var data = {
    'reference_number': reference,
    'language': locale,
    'type': isHouse ? 'House' : 'Service',
    "auth_key": "dGVtcG9ib29raW5nOmFwaV9BdXRoMUAqJjZSVEQ=",
  };
  try {
    var dioOptions = BaseOptions(
      baseUrl: 'http://dowide.asattek.com/api',
      connectTimeout: 8000,
      receiveTimeout: 8000,
      contentType: Headers.formUrlEncodedContentType,
    );
    Dio dio = Dio(dioOptions);
    Response response =
        await dio.post('/customer/payments/receipts', data: data);
    if (response.statusCode == 200) {
      // print(response.data);
      String responseDtata = response.data['receipt'];
      if (responseDtata.length == 20) {
        receiptNumber = responseDtata;
        await AppData().storeValue("BOOKING_RECEIPT", receiptNumber);
      } else {
        receiptNumber = response.data['message'];
      }
    }
  } on DioError {
    receiptNumber = "connection_problems".tr;
  }

  return Future<String>.value(receiptNumber);
}
