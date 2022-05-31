import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';
import 'package:tempo/models/room_models.dart';
import 'package:tempo/models/services.dart';
import 'package:tempo/pages/booking/booking_page.dart';
import 'package:flutter/material.dart';
import 'package:tempo/widgets/stateless/photo_thumbnail.dart';
import '../preferences/shared_preferences.dart';
import 'package:tempo/widgets/satefull/description_dialog.dart';

class RoomAdapter extends StatelessWidget {
  final RoomModel roomModel;
  final String thumbNailPhoto;
  final ServiceModel serviceModel;
  final isHouse = false;
  const RoomAdapter({
    Key? key,
    required this.roomModel,
    required this.thumbNailPhoto,
    required this.serviceModel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    NumberFormat formater = NumberFormat.decimalPattern();
    return InkWell(
      onTap: () {
        _keepPrefs();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BookingPage(
                    roomModel: roomModel,
                    serviceModel: serviceModel,
                    isHouse: isHouse)));
      },
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          topLeft: Radius.circular(15))),
                  height: MediaQuery.of(context).size.width / 3,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        topLeft: Radius.circular(15)),
                    child: PhotoThumbnailAdapter(imageUrl: thumbNailPhoto),
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 10, right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(roomModel.roomName,
                              style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.bodyText2!.color,
                                fontSize: 16,
                              )),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  '${formater
                                          .format(int.parse(roomModel.price))}.00TZS',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .color,
                                      fontSize: 14)),
                              Text('${roomModel.hours} hours',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .color,
                                      fontSize: 14))
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                        useSafeArea: true,
                                        context: context,
                                        builder: (_) => DescriptionDialog(
                                            description:
                                                roomModel.roomDescription));
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)),
                                    ),
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 5, bottom: 5),
                                    height: 35,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.info_outline_rounded,
                                            color: Colors.white),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: InkWell(
                                  onTap: () {
                                     _keepPrefs();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BookingPage(
                                                roomModel: roomModel,
                                                serviceModel: serviceModel,
                                                isHouse: isHouse)));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).backgroundColor,
                                      borderRadius: const BorderRadius.only(
                                          bottomRight: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                    ),
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20, top: 0, bottom: 0),
                                    height: 35,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text('book'.tr,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12)),
                                        const SizedBox(width: 10),
                                        const Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            color: Colors.black,
                                            size: 12),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      )))
            ],
          ),
        ),
      ),
      // child: Image.asset('assets/images/hotel.jpg', height: 50),
    );
  }

  Future<void> _keepPrefs() async {
    await AppData().storeValue('BOOKING_PRICE', roomModel.price);
    await AppData().storeValue('BOOKING_ROOM_NAME', roomModel.roomName);
    await AppData().storeValue('BOOKING_ROOM_TYPE', roomModel.roomType);
    await AppData().storeValue('BOOKING_ROOM_ID', roomModel.roomId);
    await AppData().storeValue('BOOKING_MIN_DURATION', roomModel.hours);
    await AppData().storeValue('BOOKING_DESCRIPTION', roomModel.roomDescription);
  }
}
