import 'package:tempo/http/api.dart';
import 'package:tempo/models/rental_detail_models.dart';
import 'package:tempo/models/rental_model.dart';
import 'package:tempo/pages/dashboard/tabs/menu_tab.dart';
import 'package:tempo/preferences/shared_preferences.dart';

List<RentalModel> futureRentals = [];
List<RentalModel> sortedRentals = [];
List<RentalModel> fetchedRentals = [];

Future<List<RentalModel>?> fetchFutureRentals(String key) async {
  var offset = futureRentals.length;
  var api = '/customer/rental/houses/$offset';
  try {
    futureRentals.clear();
    await httpInit();
    response = await dio.get(api);
    if (response.statusCode == 200) {
      final list = response.data as List;
      fetchedRentals = list.map((e) => RentalModel.fromJson(e)).toList();
      futureRentals.addAll(fetchedRentals);
    }
    if (key.isNotEmpty) {
      String searchKey = key.toLowerCase();
      if (futureRentals.isNotEmpty) {
        sortedRentals.clear();
        for (int i = 0; i < futureRentals.length; i++) {
          if (futureRentals[i].name.toLowerCase().contains(searchKey) ||
              futureRentals[i].region.toLowerCase().contains(searchKey) ||
              futureRentals[i].district.toLowerCase().contains(searchKey)) {
            sortedRentals.add(futureRentals[i]);
            // print(futureRentals[i].name);
          }
        }
      }
    }
    // ignore: empty_catches
  } catch (ex) {
    // print(ex);
  }
  isLoadingHttp = false;
  return key.isNotEmpty ? sortedRentals : futureRentals;
}



Future<RentalDetail?> checkPayments(String house) async {
  RentalDetail? rentalDetail;
  bool isAuthenticated = await AppData().getBool("isAuthenticated");
  final String api = isAuthenticated
      ? '/customer/auth/rental/house/$house'
      : '/customer/rental/house/$house';
  try {
    await httpInit();
    response = await dio.get(api);
    if (response.statusCode == 200) {
      // print(response.data);
      rentalDetail = RentalDetail.fromJson(response.data['data']);
    }

    // ignore: empty_catches
  } catch (ex) {
    // print(ex);
  }
  return rentalDetail;
}
