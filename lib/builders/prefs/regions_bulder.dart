import 'dart:convert';

import 'package:flutter/services.dart' as rootbundles;
import 'package:tempo/models/regions.dart';
import 'package:tempo/preferences/shared_preferences.dart';

Future<List<Regions>> loadRegions(String query) async {
  //read json file
  List<Regions> filteredRegions = [];
  final jsondata =
      await rootbundles.rootBundle.loadString('assets/json/regions.json');
  //decode json data as list
  final list = json.decode(jsondata) as List<dynamic>;
  var regionsData = list.map((e) => Regions.fromJson(e)).toList();
  if (query.isNotEmpty) {
    filteredRegions.clear();
    for (int i = 0; i < regionsData.length; i++) {
      if (regionsData[i].name.toLowerCase().contains(query.toLowerCase())) {
        Regions region = Regions(name: regionsData[i].name);
        filteredRegions.add(region);
      }
    }
    return filteredRegions;
  }
  return regionsData;
}

Future<String?> selectedRegion() async {
  
  String? region = await AppData().getString('REGION');
  return region;
}
