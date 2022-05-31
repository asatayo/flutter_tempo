import 'package:tempo/http/api.dart';
import 'package:tempo/models/rental_room_models.dart';
import 'package:tempo/preferences/shared_preferences.dart';

List<RentalRoomModel> rentalRoomsList = [];
int rentalRoomsTrialCount = 0;
Future<void> httpLoadRentalRooms(String house, finishedLoading) async {
  bool? isAuthenticated = await AppData().getBool("isAuthenticated");

  final String api;
  if (isAuthenticated) {
    api = '/customer/auth/rental/house/$house';
  } else {
    api = '/customer/rental/house/$house';
  }
  // print(api);

  try {
    await httpInit();

    response = await dio.get(api);

    if (response.statusCode == 200) {
      final list = response.data['rooms'] as List<dynamic>;
      // print(response.data);
      var fetchedList = list.map((e) => RentalRoomModel.fromJson(e)).toList();

      if (fetchedList.isNotEmpty) {
        rentalRoomsList.clear();
        rentalRoomsList.addAll(fetchedList);
      }

      String message = "Services loaded successfully";
      finishedLoading(false, message);
      // print(message);
    } else {
      if (rentalRoomsTrialCount < 10) {
        rentalRoomsTrialCount++;
        httpLoadRentalRooms(house, finishedLoading);
      } else {
        String message = "Finished loading with failure";
        finishedLoading(false, message);
        // print(message);
      }
    }
  } catch (ex) {
    // print(ex);
    if (rentalRoomsTrialCount < 10) {
      rentalRoomsTrialCount++;
      httpLoadRentalRooms(house, finishedLoading);
    } else {
      String message = "Finished loading services";
      finishedLoading(false, message, );
    }
  }
}

