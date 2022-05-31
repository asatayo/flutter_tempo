import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tempo/builders/http/rental_rooms.dart';
import 'package:tempo/builders/http/rentals_builder.dart';
import 'package:tempo/http/services_http.dart';
import 'package:tempo/pages/dashboard/tabs/menu_tab.dart';
import 'package:tempo/preferences/shared_prefs_fun.dart';

class CategoryAdapter extends StatelessWidget {
  final String name;
  final String iconPath;
  final bool isHouse;
  final bool isRental;
  final bool isChecked;
  final int position;
  final String value;
  final Function notifyParent;
  final Function notifyChild;
  const CategoryAdapter(
      {Key? key,
      required this.name,
      required this.iconPath,
      required this.isChecked,
      required this.position,
      required this.notifyChild,
      required this.isHouse,
      required this.isRental,
      required this.value,
      required this.notifyParent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          futureRentals.clear();
          servicesList.clear();
          futureRentalRooms.clear();
          isLoadingHttp = true;
          await keepPrefs(isHouse, isRental, position, name, value);
          notifyParent();
          notifyChild();
        },
        child: SizedBox(
          width: 100,
          height: 100,
          child: Column(
            children: [
              Stack(children: [
                Positioned(
                    child: Container(
                  height: isChecked ? 65 : 60,
                  width: isChecked ? 65 : 60,
                  padding: EdgeInsets.all(isChecked ? 5 : 3),
                  decoration: BoxDecoration(
                    color: isChecked
                        ? Theme.of(context).iconTheme.color
                        : Colors.amber,
                    borderRadius: const BorderRadius.all(Radius.circular(60)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.asset(
                      iconPath,
                      width: 60,
                      height: 60,
                    ),
                  ),
                )),
                isChecked
                    ? Positioned(
                        bottom: 0,
                        right: 5,
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          padding: const EdgeInsets.all(4),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: Theme.of(context).iconTheme.color,
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                          ),
                          child: FaIcon(
                            FontAwesomeIcons.check,
                            color: Theme.of(context).primaryColor,
                            size: 12,
                          ),
                        ),
                      )
                    : const SizedBox(
                        height: 5,
                      ),
              ]),
              const SizedBox(
                height: 10,
              ),
              Text(name.tr,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight:
                          isChecked ? FontWeight.bold : FontWeight.normal)),
            ],
          ),
        ));
  }
}
