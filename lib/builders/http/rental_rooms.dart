import 'package:tempo/http/api.dart';
import 'package:tempo/models/rental_room_models.dart';
import 'package:tempo/preferences/shared_preferences.dart';

List<RentalRoomModel> futureRentalRooms = [];
Future<List<RentalRoomModel>> getFutureRentalRooms(String house) async {
  bool? isAuthenticated = await AppData().getBool("isAuthenticated");

  final String api;
  if (isAuthenticated) {
    api = '/customer/auth/rental/house/$house';
  } else {
    api = '/customer/rental/house/$house';
  }
  // final String api = isAuthenticated
  //   ? '/customer/auth/rental/house/'
  //   : '/customer/rental/house/' + service;
  // print(api);
  try {
    await httpInit();
    response = await dio.get(api);
    if (response.statusCode == 200) {
      final list = response.data['rooms'] as List<dynamic>;
      futureRentalRooms = list.map((e) => RentalRoomModel.fromJson(e)).toList();
      // print(response.data);
    }

    // ignore: empty_catches
  } catch (ex) {
    // print(ex);
  }
  return futureRentalRooms;
}
