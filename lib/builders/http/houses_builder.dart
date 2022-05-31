import 'package:dio/dio.dart';
import 'package:tempo/models/house_model.dart';
import 'package:tempo/pages/dashboard/tabs/menu_tab.dart';

Future<List<HouseModel>> fetchFutureHouses(String key) async {
  var offset = '0';
  String count = "All";
  var api = '/customer/houses/$count/$offset';
  // print(api);
  List<HouseModel> futureHouses = [];
  List<HouseModel> sortedHouses = [];

  try {
    futureHouses.clear();
    var dioOptions = BaseOptions(
      baseUrl: 'https://tempoapplication.com/api',
      connectTimeout: 16000,
      receiveTimeout: 16000,
    );
    Dio dio = Dio(dioOptions);
    Response response = await dio.get(api);
    if (response.statusCode == 200) {
      final list = response.data as List<dynamic>;
      futureHouses = list.map((e) => HouseModel.fromJson(e)).toList();
    }

    if (key.isNotEmpty) {
      String searchKey = key.toLowerCase();
      sortedHouses.clear();
      for (int i = 0; i < futureHouses.length; i++) {
        if (futureHouses.isNotEmpty) {
          if (futureHouses[i].name.toLowerCase().contains(searchKey) ||
              futureHouses[i].region.toLowerCase().contains(searchKey) ||
              futureHouses[i].district.toLowerCase().contains(searchKey)) {
            sortedHouses.add(futureHouses[i]);
          }
        }
      }
    }
    // ignore: empty_catches
  } on DioError {}
  isLoadingHttp = false;
  return key.isNotEmpty ? sortedHouses : futureHouses;
}
