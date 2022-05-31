import 'package:flutter/material.dart';
import 'package:tempo/adapters/category_adapter.dart';
import 'package:tempo/builders/category_builder.dart';
import 'package:tempo/models/categories.dart';
import 'package:get/get.dart';
class ServiceCategories extends StatefulWidget {
  final Function notifyParent;
  final Function notifyChild;
  const ServiceCategories({Key? key, required this.notifyChild, required this.notifyParent})
      : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _ServiceCategoriesState createState() => _ServiceCategoriesState();
}
class _ServiceCategoriesState extends State<ServiceCategories> {
  late String name, value, iconPath;
  late  int position;
  late bool isChecked, isHouse,isRental;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: FutureBuilder(
        builder: (BuildContext context, data) {
          if (data.hasData) {
            var categories = data.data as List<ServiceCategory>;
            if (categories.isNotEmpty) {
              return ListView.builder(
                  itemCount: categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, index) {
                    name = categories[index].name;
                    value = categories[index].value;
                    position = index;
                    iconPath = categories[index].iconPath;
                    isChecked = categories[index].isChecked;
                    isHouse = categories[index].isHouse;
                    isRental = categories[index].isRental;

                    return CategoryAdapter(
                      position: position,
                      isHouse: isHouse,
                      isRental: isRental,
                      value: value,
                      name: name,
                      iconPath: iconPath,
                      isChecked: isChecked,
                      notifyParent: widget.notifyParent,
                      notifyChild: widget.notifyChild,
                    );
                  });
            } else {
              return SizedBox(
                height: 120,
                child: Center(child: Text('no_category'.tr)),
              );
            }
          } else if (data.hasError) {
            return const CircularProgressIndicator();
          } else {
            return const CircularProgressIndicator();
          }
        },
        future: loadCategory(),
      ),
    );
  }
}

