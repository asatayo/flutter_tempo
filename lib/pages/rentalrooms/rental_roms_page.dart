import 'package:tempo/builders/http/rental_rooms.dart';
import 'package:tempo/models/rental_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tempo/widgets/stateless/image.dart';
import 'package:get/get.dart';

import '../../adapters/rental_room_adapter.dart';
import '../../models/rental_room_models.dart';

class RentalRoomsPage extends StatefulWidget {
  final RentalModel rentalModel;
  const RentalRoomsPage({
    Key? key,
    required this.rentalModel,
  }) : super(key: key);

  @override
  RentalRoomsPageState createState() => RentalRoomsPageState();
}

class RentalRoomsPageState extends State<RentalRoomsPage> {
  late Future<List<RentalRoomModel>> futureRentalRooms;

  @override
  void initState() {
    super.initState();
    futureRentalRooms = getFutureRentalRooms(widget.rentalModel.houseId);

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back_ios_outlined,
                          color: Theme.of(context).textTheme.bodyText2!.color),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                    floating: false,
                    pinned: true,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(50)),
                          child: ImageDataSized(
                            imageUrl: widget.rentalModel.bannerThumbNail,
                            height: 50,
                            width: 50,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(widget.rentalModel.name,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .color)),
                      ],
                    ),
                  ),
                ];
              },
              body: ListView(
                children: [
                  _loadRooms(context, widget.rentalModel.houseId,
                      widget.rentalModel.category, widget.rentalModel.name),
                  tempoInstructions(widget.rentalModel.instruction),
                  
                ],
              ),
            )));
  }

  Widget tempoInstructions(String instruction) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text('instructions'.tr,
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).textTheme.bodyText2!.color,
              )),
          const SizedBox(
            height: 20,
          ),
          Text(instruction, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }

  Widget _loadRooms(BuildContext context, String service, String serviceName,
      String category) {
    String thumbNailPhoto;
    return Container(
      padding: const EdgeInsets.all(10),
      color: Theme.of(context).primaryColor,
      child: FutureBuilder(
        future: futureRentalRooms,
        builder: (context, snapshort) {
          if (snapshort.hasData) {
            var rooms = snapshort.data as List<RentalRoomModel>;
            if (rooms.isNotEmpty) {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                primary: true,
                itemCount: snapshort.data == null ? 0 : rooms.length,
                itemBuilder: (context, index) {
                  if (rooms[index].roomThumbNails.isNotEmpty) {
                    thumbNailPhoto = rooms[index].roomThumbNails[0].imageuUrl;
                  } else {
                    thumbNailPhoto = widget.rentalModel.bannerThumbNail;
                  }
                  return RentalRoomAdapter(
                      thumbNailPhoto: thumbNailPhoto,
                      rentalRoomModel: rooms[index],
                      rentalModel: widget.rentalModel,

                  );
                },
              );
            } else {
              return SizedBox(
                height: MediaQuery.of(context).size.height - 360,
                child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FaIcon(
                          // ignore: deprecated_member_use
                          FontAwesomeIcons.sadCry,
                          size: 60,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('No rooms', style: TextStyle(fontSize: 30)),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: const Text(
                              'You are not able to see rooms because this service has any registered room yet. You can opt to visit here next time to see if there is any update ',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              );
            }
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
