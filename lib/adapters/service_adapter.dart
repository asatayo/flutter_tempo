import 'package:tempo/pages/services/service_page.dart';
import 'package:tempo/models/services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../preferences/shared_preferences.dart';

class ServiceAdapter extends StatelessWidget {
  
  final ServiceModel serviceModel;

  const ServiceAdapter({Key? key, required this.serviceModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
         _keepPrefs();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ServicePage(serviceModel: serviceModel)));
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
                      serviceModel.bannerThumbNail, 
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
                      child: Text(serviceModel.name,
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
                        // Text('4.5', style: TextStyle(fontSize: 10)),
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
                                  '${serviceModel.district} ${serviceModel.region}',
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
    await AppData().storeValue('BOOKING_SERVICE_NAME', serviceModel.name);
    await AppData().storeValue('BOOKING_SERVICE_CATEOGRY', serviceModel.category);
    // await AppData().storeValue('BOOKING_MIN_DURATION', "3");
    await AppData().storeValue('BOOKING_SERVICE_ID', serviceModel.serviceId);
  }
}
