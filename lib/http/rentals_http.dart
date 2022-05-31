import 'package:tempo/http/api.dart';
import 'package:tempo/models/rental_model.dart';
import '../../preferences/shared_preferences.dart';

List<RentalModel> rentalsList = [];
List<RentalModel> filteredRentalsList = [];

int rentalTrialCount = 0;

Future<void> httpLoadRentals(int offset, String key, finishedLoading) async {
  String offsetString = offset.toString();
  String? category = await AppData().getString('VALUE');
  category ??= "Rental";
  // var api = '/customer/rentals/$category/$offsetString';
  var api = '/customer/rental/houses/$offsetString';

  try {
    await httpInit();

    response = await dio.get(api);

    if (response.statusCode == 200) {
      final list = response.data as List;
      // print(response.data);
      var fetchedList = list.map((e) => RentalModel.fromJson(e)).toList();

      if (fetchedList.isNotEmpty) {
        if (offset == 0) {
          rentalsList.clear();
        }
        rentalsList.addAll(fetchedList);
      }

      String message = "Rentals loaded successfully";
      finishedLoading(true, message);
      // print(message);
    } else {
      if (rentalTrialCount < 10) {
        rentalTrialCount++;
        httpLoadRentals(offset, key, finishedLoading);
      } else {
        String message = "Finished loading with failure";
        finishedLoading(false, message);
        // print(message);
      }
    }
  } catch (ex) {
    // print(ex);
    if (rentalTrialCount < 10) {
      rentalTrialCount++;
      httpLoadRentals(offset, key, finishedLoading);
    } else {
      String message = "Finished loading rentals";
      finishedLoading(false, message);
    }
  }
}



List<RentalModel> premiumRentalsList = [];

Future<void> httpLoadpremiumRentals(
    int offset, String key, finishedLoading) async {
  String offsetString = offset.toString();
  String? category = await AppData().getString('VALUE');
  category ??= "Hotel";
  var api = '/customer/rentals/$category/$offsetString';
  // print(api);
  try {
    await httpInit();

    response = await dio.get(api);

    if (response.statusCode == 200) {
      final list = response.data as List;
      // print(response.data);
      var fetchedList = list.map((e) => RentalModel.fromJson(e)).toList();

      if (fetchedList.isNotEmpty) {
        if (offset == 0) {
          premiumRentalsList.clear();
        }
        premiumRentalsList.addAll(fetchedList);
      }

      String message = "Rentals loaded successfully";
      finishedLoading(false, message);
      // print(message);
    } else {
      if (rentalTrialCount < 10) {
        rentalTrialCount++;
        httpLoadpremiumRentals(offset, key, finishedLoading);
      } else {
        String message = "Finished loading with failure";
        finishedLoading(false, message);
        // print(message);
      }
    }
  } catch (ex) {
    // print(ex);
    if (rentalTrialCount < 10) {
      rentalTrialCount++;
      httpLoadpremiumRentals(offset, key, finishedLoading);
    } else {
      String message = "Finished loading rentals";
      finishedLoading(false, message);
    }
  }
}
