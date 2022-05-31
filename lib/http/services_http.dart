import 'package:tempo/http/api.dart';
import 'package:tempo/models/services.dart';
import '../../preferences/shared_preferences.dart';

List<ServiceModel> servicesList = [];
List<ServiceModel> filteredServicesList = [];

int serviceTrialCount = 0;

Future<void> httpLoadServices(int offset, String key, finishedLoading) async {
  String offsetString = offset.toString();
  String? category = await AppData().getString('VALUE');
  category ??= "Hotel";
  var api = '/customer/services/$category/$offsetString';

  try {
    await httpInit();

    response = await dio.get(api);

    if (response.statusCode == 200) {
      final list = response.data as List;
      // print(response.data);
      var fetchedList = list.map((e) => ServiceModel.fromJson(e)).toList();

      if (fetchedList.isNotEmpty) {
        if (offset == 0) {
          servicesList.clear();
        }
        servicesList.addAll(fetchedList);
      }

      String message = "Services loaded successfully";
      finishedLoading(false, message);
      // print(message);
    } else {
      if (serviceTrialCount < 10) {
        serviceTrialCount++;
        httpLoadServices(offset, key, finishedLoading);
      } else {
        String message = "Finished loading with failure";
        finishedLoading(false, message);
        // print(message);
      }
    }
  } catch (ex) {
    // print(ex);
    if (serviceTrialCount < 10) {
      serviceTrialCount++;
      httpLoadServices(offset, key, finishedLoading);
    } else {
      String message = "Finished loading services";
      finishedLoading(false, message);
    }
  }
}

List<ServiceModel> premiumServicesList = [];

Future<void> httpLoadpremiumServices(
    int offset, String key, finishedLoading) async {
  String offsetString = offset.toString();
  String? category = await AppData().getString('VALUE');
  category ??= "Hotel";
  var api = '/customer/services/$category/$offsetString';
  // print(api);
  try {
    await httpInit();

    response = await dio.get(api);

    if (response.statusCode == 200) {
      final list = response.data as List;
      // print(response.data);
      var fetchedList = list.map((e) => ServiceModel.fromJson(e)).toList();

      if (fetchedList.isNotEmpty) {
        if (offset == 0) {
          premiumServicesList.clear();
        }
        premiumServicesList.addAll(fetchedList);
      }

      String message = "Services loaded successfully";
      finishedLoading(false, message);
      // print(message);
    } else {
      if (serviceTrialCount < 10) {
        serviceTrialCount++;
        httpLoadpremiumServices(offset, key, finishedLoading);
      } else {
        String message = "Finished loading with failure";
        finishedLoading(false, message);
        // print(message);
      }
    }
  } catch (ex) {
    // print(ex);
    if (serviceTrialCount < 10) {
      serviceTrialCount++;
      httpLoadpremiumServices(offset, key, finishedLoading);
    } else {
      String message = "Finished loading services";
      finishedLoading(false, message);
    }
  }
}
