// import 'package:flutter/services.dart';
// import 'package:mobile_number/mobile_number.dart';
// import 'package:permission_handler/permission_handler.dart';

// Future<bool> hasSingleSimCard() async {
//   bool isSingle = true;
//   try {
//     var status = await Permission.phone.status;
//     if (!status.isGranted) {
//       bool isGranted = await Permission.phone.request().isGranted;
//       if (!isGranted) {
//         isSingle = true;
//       }
//     }
//   }
//   // ignore: empty_catches
//   catch (e) {}
//   MobileNumber.listenPhonePermission((isPermissionGranted) async {
//     if (isPermissionGranted) {
//       if (!await MobileNumber.hasPhonePermission) {
//         await MobileNumber.requestPhonePermission;
//         return true;
//       }
//       try {
//         List<SimCard> _allSimCards = <SimCard>[];
//         // ignore: avoid_print
//         print(_allSimCards.length);
//         // mobileNumber = (await MobileNumber.mobileNumber);
//         _allSimCards = (await MobileNumber.getSimCards);
//         if (_allSimCards.length > 1) {
//           isSingle = false;
//         }
//         isSingle = true;
//       } on PlatformException {
//         isSingle = true;
//       }
//     } else {
//       isSingle = true;
//     }
//   });

//   return Future.value(isSingle);
// }

// Future<bool> hasSingleSimCard() async {
//   bool isSingle;
//   try {
//     var status = await Permission.phone.status;
//     if (!status.isGranted) {
//       bool isGranted = await Permission.phone.request().isGranted;
//       if (!isGranted) {
//         isSingle = true;
//       }
//     }
//     try {
//       SimData simData = await SimDataPlugin.getSimData();
//       if (simData != null && simData.cards.length > 1) {
//         isSingle = false;
//       } else {
//         isSingle = true;
//       }
//     } on PlatformException catch (e) {
//       debugPrint("error! code: ${e.code} - message: ${e.message}");
//     }
//   } catch (e) {
//     isSingle = true;
//     debugPrint(e.toString());
//   }
//   return Future.value(isSingle);
// }
