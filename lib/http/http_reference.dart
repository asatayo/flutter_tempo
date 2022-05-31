import 'package:tempo/fireabase.dart';
import 'package:tempo/http/api.dart';
import 'package:tempo/models/rental_detail_models.dart';
import 'package:tempo/models/unpaid_model.dart';
import 'package:tempo/preferences/shared_preferences.dart';

int paymentStatusTrialCount = 0;
RentalDetail? rentalDetailModel;
UnpaidRentalModel? unpaidRentalModel;

httpStatusCheck(
    String house, bool isRoom, bool isUpdate, finishedLoading) async {
  String? fcmToken = await requestFbToken();
  String language = await AppData().getLocale();
  const String api = '/customer/auth/rental/house/payment/reference';

  try {
    var data = {
      'house': house,
      'fcm_token': fcmToken,
      'language': language,
      'isupdate': isUpdate,
      'isroom': isRoom ? 1 : 0,
    };

    print(data);

    await httpInit();
    response = await dio.post(api, data: data);

    print(response.data);
    if (response.statusCode == 200) {
      if (response.data['isreference']) {
        String refNumber = response.data['reference'];
        await AppData().storeValue('RENTAL_REFERENCE_ID', house);
        await AppData().storeValue('RENTAL_REFERENCE_NUMBER', refNumber);

        finishedLoading(true, true, false, refNumber);
      } else {
        if (response.data['isactive']) {
          
          rentalDetailModel = RentalDetail.fromJson(response.data['rental']);
          String message = "Finished loading with success";
          print(message);
          finishedLoading(true, false, true, message);
        } else {
          unpaidRentalModel =
              UnpaidRentalModel.fromJson(response.data['rental']);

          String message = "Finished loading with success";
          finishedLoading(true, false, false, message);
        }
      }
    } else {
      if (paymentStatusTrialCount < 10) {
        paymentStatusTrialCount++;
        httpStatusCheck(house, isRoom, isUpdate, finishedLoading);
      } else {
        String message = "Finished loading with failure";
        finishedLoading(false, false, false, message);
        // print(message);
      }
    }
    // ignore: empty_catches
  } catch (ex) {
    print(ex);
    // if (paymentStatusTrialCount < 10) {
    //   paymentStatusTrialCount++;
    //   httpStatusCheck(house, isRoom, isUpdate, finishedLoading);
    // } else {
    //   String message = "Finished loading with failure";
    //   finishedLoading(false, false, false, message);
    //   // print(message);
    // }
  }
}
