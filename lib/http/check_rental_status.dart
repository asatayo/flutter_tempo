import 'package:tempo/http/api.dart';
import 'package:tempo/models/rental_detail_models.dart';
import 'package:tempo/preferences/shared_preferences.dart';

int paymentStatusTrialCount = 0;
// Future<void> httpCheckPaymentStatus(String house, finishedLoading) async {
//   RentalDetail? rentalDetail;
//   bool isAuthenticated = await AppData().getBool("isAuthenticated");
//   final String api = isAuthenticated
//       ? '/customer/auth/rental/house/$house'
//       : '/customer/rental/house/$house';

//   // print(api);
//   try {
//     await httpInit();
//     response = await dio.get(api);
//     // print(response.data);
//     if (response.statusCode == 200) {
//       rentalDetail = RentalDetail.fromJson(response.data);
//       String message = "Loaded successfully";
//       finishedLoading(true, message, rentalDetail);
//       // print(message);
//     } else {
//       if (paymentStatusTrialCount < 10) {
//         paymentStatusTrialCount++;
//         httpCheckPaymentStatus(house, finishedLoading);
//       } else {
//         String message = "Finished loading with failure";
//         finishedLoading(false, message, rentalDetail);
//         // print(message);
//       }
//     }
//   } catch (ex) {
//     if (paymentStatusTrialCount < 10) {
//       paymentStatusTrialCount++;
//       httpCheckPaymentStatus(house, finishedLoading);
//     } else {
//       String message = "Finished loading with failure";
//       finishedLoading(false, message, rentalDetail);
//       // print(ex);
//     }
//   }
// }
