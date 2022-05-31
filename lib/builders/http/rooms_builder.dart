import 'package:tempo/http/api.dart';
import 'package:tempo/models/room_models.dart';

List<RoomModel> futureRooms = [];
Future<List<RoomModel>> getFutureRooms(String service) async {
  // var offset = '0';
  // bool isAuthenticated = await AppData().getBool("isAuthenticated") ?? false;

  // final String api = isAuthenticated? '/customer/auth/rental/house/' : '/customer/rental/house/' + service ;

  final String api = '/customer/rooms/$service';
//  print(api);
  try {
    await httpInit();
    response = await dio.get(api);
    if (response.statusCode == 200) {
      final list = response.data as List<dynamic>;
      futureRooms = list.map((e) => RoomModel.fromJson(e)).toList();
    }
    // ignore: empty_catches
  } catch (ex) {
    // print(ex);
  }
  return futureRooms;
}
