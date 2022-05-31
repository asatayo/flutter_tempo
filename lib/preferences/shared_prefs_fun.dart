import 'package:tempo/fireabase.dart';
import "package:tempo/models/payment_model.dart";
import 'package:tempo/preferences/shared_preferences.dart';

Future<void> storePaymentReceipt(String receipt, String referenceNumber) async {
  await AppData().storeValue("BOOKING_PAID", true);
  await AppData().storeValue("BOOKING_WAITING", false);
  await AppData().storeValue("BOOKING_RECEIPT", receipt);
  await AppData().storeValue("BOOKING_REFERENCE_NUMBER", referenceNumber);
  await AppData().removeData("NEW_REFERENCE_NUMBER");
}

Future<PaymentModel> paymentDataToModel() async {
  bool isHouse = await AppData().getBool("ISHOUSE");
  bool isPaid = await AppData().getBool("IS_BOOKING_PAID");
  bool isCooperate = await AppData().getBool("IS_COOPERATE");

  //service based prefs
  String? serviceName = await AppData().getString("BOOKING_SERVICE_NAME");
  String? category = await AppData().getString(
      isHouse ? "BOOKING_HOUSE_CATEOGRY" : "BOOKING_SERVICE_CATEOGRY");
  String? serviceId = await AppData().getString("BOOKING_SERVICE_ID");

  //house based prefs
  String? houseName = await AppData().getString("BOOKING_HOUSE_NAME");
  String? houseId = await AppData().getString("BOOKING_HOUSE_ID");
  //shared values
  String? minDuration = await AppData().getString("BOOKING_MIN_DURATION");
  String? price = await AppData().getString("BOOKING_PRICE");
  String? description = await AppData().getString("BOOKING_DESCRIPTION");
  //room based data
  String? roomName = await AppData().getString("BOOKING_ROOM_NAME");
  String? roomType = await AppData().getString("BOOKING_ROOM_TYPE");
  String? roomId = await AppData().getString("BOOKING_ROOM_ID");
  String? operatorType = await AppData().getString("BOOKING_OPERATOR");
  String? ussdCode = await AppData().getString("BOOKING_USSD");
  String? amount = await AppData().getString("BOOKING_TOTAL");
  String? entryDateTime = await AppData().getString("BOOKING_ENTRY_DATE");
  String? exitDateTime = await AppData().getString("BOOKING_EXITDATE");
  String? duration = await AppData().getString("BOOKING_DURATION");
  String? referenceNumber =
      await AppData().getString("BOOKING_REFERENCE_NUMBER");
  String? cooperateNumber = await AppData().getString("COOPERATE_NUMBER");
  String? roomsCount = await AppData().getString("ROOMS_COUNT");
  String? receiptNumber = await AppData().getString("BOOKING_RECEIPT");

  String? fcmToken = await requestFbToken();
  String? locale = await AppData().getLocale();
  String? authKey = "dGVtcG9ib29raW5nOmFwaV9BdXRoMUAqJjZSVEQ=";

  PaymentModel paymentModel = PaymentModel(
      isHouse,
      isCooperate,
      isPaid,
      roomName,
      roomType,
      serviceName,
      houseName,
      roomId,
      serviceId,
      houseId,
      category,
      duration,
      minDuration,
      amount,
      entryDateTime,
      exitDateTime,
      operatorType,
      ussdCode,
      referenceNumber,
      receiptNumber,
      price,
      description,
      roomsCount,
      cooperateNumber,
          fcmToken,
      authKey, 
      locale, 
      );
  return Future.value(paymentModel);
}

// Future<PaymentModel> paymentDataToModelCooperate() async {
//   bool isHouse = false;
//   bool isPaid = true;
//   bool isCooperate = await AppData().getBool("IS_COOPERATE");

//   //service based prefs
//   String? serviceName = await AppData().getString("BOOKING_SERVICE_NAME");
//   String? category = await AppData().getString("BOOKING_SERVICE_CATEOGRY");
//   String? serviceId = await AppData().getString("BOOKING_SERVICE_ID");

//   //house based prefs
//   String? houseName = await AppData().getString("BOOKING_HOUSE_NAME");
//   String? houseId = await AppData().getString("BOOKING_HOUSE_ID");
//   //shared values
//   String? minDuration = await AppData().getString("BOOKING_MIN_DURATION");
//   String? price = await AppData().getString("BOOKING_PRICE");
//   String? description = await AppData().getString("BOOKING_DESCRIPTION");
//   //room based data
//   String? roomName = await AppData().getString("BOOKING_ROOM_NAME");
//   String? roomType = await AppData().getString("BOOKING_ROOM_TYPE");
//   String? roomId = await AppData().getString("BOOKING_ROOM_ID");
//   String? operatorType = await AppData().getString("BOOKING_OPERATOR");
//   String? ussdCode = await AppData().getString("BOOKING_USSD");
//   String? amount = await AppData().getString("BOOKING_TOTAL");
//   String? entryDateTime = await AppData().getString("BOOKING_ENTRY_DATE");
//   String? exitDateTime = await AppData().getString("BOOKING_EXITDATE");
//   String? duration = await AppData().getString("BOOKING_DURATION");
//   String? referenceNumber =
//       await AppData().getString("BOOKING_REFERENCE_NUMBER");
//   String? cooperateNumber = await AppData().getString("COOPERATE_NUMBER");
//   String? roomsCount = await AppData().getString("ROOMS_COUNT");
//   String? receiptNumber = await AppData().getString("BOOKING_RECEIPT");

//   PaymentModel modelPaymentCooperate = PaymentModel(
//       isHouse,
//       isCooperate,
//       isPaid,
//       roomName,
//       roomType,
//       serviceName,
//       houseName,
//       roomId,
//       serviceId,
//       houseId,
//       category,
//       duration,
//       minDuration,
//       amount,
//       entryDateTime,
//       exitDateTime,
//       operatorType,
//       ussdCode,
//       referenceNumber,
//       receiptNumber,
//       price,
//       description,
//       roomsCount,
//       cooperateNumber);
//   return Future.value(modelPaymentCooperate);
// }

Future<bool> isWaitingForPayment() async {
  bool isWaiting = false;
  if (await AppData().containsKey("ISWAITING_PAYMENTS")) {
    isWaiting = await AppData().getBool("ISWAITING_PAYMENTS");
  }
  return Future.value(isWaiting);
}

Future<PaymentModel> checkWaiting() async {
  PaymentModel paymentModel;
  paymentModel = await paymentDataToModel();
  return Future.value(paymentModel);
}

Future<void> keepPrefs(bool isHouse, bool isRental, int position, String name,
    String value) async {
  await AppData().storeValue("INDEX", position);
  await AppData().storeValue("NAME", name);
  await AppData().storeValue("VALUE", value);
  await AppData().storeValue("ISHOUSE", isHouse);
  await AppData().storeValue("ISRENTAL", isRental);
}

Future<void> paymentCompleted(String receipt) async {
  await AppData().storeValue("BOOKING_RECEIPT", receipt);
  await AppData().storeValue("IS_BOOKING_PAID", true);
  await AppData().removeData('NEW_REFERENCE_NUMBER');
  await AppData().removeData('ISWAITING_PAYMENTS');
}
