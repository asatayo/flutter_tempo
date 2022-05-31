import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tempo/models/house_model.dart';
import 'package:tempo/pages/house/house_page.dart';
import 'package:tempo/widgets/stateless/photo_thumbnail.dart';

import '../preferences/shared_preferences.dart';

class HouseAdapter extends StatelessWidget {
  final HouseModel houseModel;
  const HouseAdapter({
    Key? key,
    required this.houseModel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await _keepPrefs();
        // ignore: use_build_context_synchronously
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HousePage(
                      houseModel: houseModel,
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
                  child: PhotoThumbnailAdapter(
                      imageUrl: houseModel.bannerThumbNail)),
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
                      child: Text(houseModel.name,
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
                                  '${houseModel.district} ${houseModel.region}',
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
    await AppData().storeValue('BOOKING_PRICE', houseModel.price);
    await AppData().storeValue('BOOKING_HOUSE_NAME', houseModel.name);
    await AppData().storeValue('BOOKING_HOUSE_CATEOGRY', houseModel.category);
    await AppData().storeValue('BOOKING_HOUSE_ID', houseModel.houseId);
    await AppData().storeValue('BOOKING_MIN_DURATION', houseModel.days);
    await AppData().storeValue('BOOKING_DESCRIPTION', houseModel.description);
  }
}
