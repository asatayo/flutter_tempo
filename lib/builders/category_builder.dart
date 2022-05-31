import 'dart:convert';

import 'package:tempo/models/categories.dart';
import 'package:flutter/services.dart' as rbundles;
import '../preferences/shared_preferences.dart';
Future<List<ServiceCategory>> loadCategory() async {
  List<ServiceCategory> itemCateg = [];
  try {
    int  itemIndex = await AppData().getInt('INDEX');
    final jsondata =
    await rbundles.rootBundle.loadString('assets/json/categories.json');
    final list = json.decode(jsondata) as List<dynamic>;
    var cList = list.map((e) => ServiceCategory.fromJson(e)).toList();
    for (int i = 0; i < cList.length; i++) {
      ServiceCategory serviceCategory = ServiceCategory(
          isChecked: itemIndex == i,
          name: cList[i].name,
          value: cList[i].value,
          iconPath: cList[i].iconPath,
          isHouse: cList[i].isHouse,
           isRental: cList[i].isRental,
          );
      itemCateg.add(serviceCategory);
    }
  } catch (ex) {
    // print(ex);
  }
  return itemCateg;
}
