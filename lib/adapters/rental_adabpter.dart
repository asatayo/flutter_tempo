import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tempo/pages/dashboard/tabs/menu_tab.dart';
import 'package:tempo/pages/rental/rental_page.dart';
import '../preferences/shared_preferences.dart';

import '../models/rental_model.dart';

bool _isAuthenticated = false;

class RentalAdapter extends StatelessWidget {
  final RentalModel rentalModel;
  const RentalAdapter({
    Key? key,
    required this.rentalModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        _keepPrefs();

        selectedModel = rentalModel;

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RentalPage(
                      rentalModel: rentalModel,
                      isAuthenticated: _isAuthenticated,
                    )));
      },
      child: Card(
        color: Theme.of(context).cardTheme.color,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5))),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15))),
              height: MediaQuery.of(context).size.width / 3.5,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15)),
                child: Image.network(
                  rentalModel.bannerThumbNail,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Container(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3.5,
                      child: Text(rentalModel.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // ignore: prefer__literals_to_create_immutables
                      children: const [
                        FaIcon(FontAwesomeIcons.star,
                            color: Colors.amber, size: 10),
                        SizedBox(
                          width: 5,
                        ),
                        Text('4.5', style: TextStyle(fontSize: 10)),
                      ],
                    ),
                  ]),
            ),
            const SizedBox(
              height: 1,
            ),
            Container(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 0, bottom: 2),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2.4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          // ignore: prefer__literals_to_create_immutables
                          children: [
                            // ignore: deprecated_member_use
                            const FaIcon(FontAwesomeIcons.mapMarkerAlt,
                                color: Colors.amber, size: 12),
                            const SizedBox(width: 5),
                            SizedBox(
                              width:
                                  MediaQuery.of(context).size.width / 2.4 - 15,
                              child: Text(
                                  '${rentalModel.district} ${rentalModel.region}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  )),
                            )
                          ],
                        )),
                  ]),
            ),
          ],
        ),
        // child: Image.asset('assets/images/hotel.jpg', height: 50),
      ),
    );
  }

  Future<void> _keepPrefs() async {
    _isAuthenticated = (await AppData().getBool('isAuthenticated'));
    await AppData().storeValue('BOOKING_PRICE', rentalModel.price);
    await AppData().storeValue('BOOKING_HOUSE_NAME', rentalModel.name);
    await AppData().storeValue('BOOKING_HOUSE_CATEOGRY', rentalModel.category);
    await AppData().storeValue('BOOKING_HOUSE_ID', rentalModel.houseId);
    await AppData().storeValue('BOOKING_MIN_DURATION', rentalModel.months);
    await AppData().storeValue('BOOKING_DESCRIPTION', rentalModel.description);
  }
}
