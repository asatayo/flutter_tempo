import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tempo/builders/http/rentals_builder.dart';
import 'package:tempo/http/check_rental_status.dart';
import 'package:tempo/http/rental_rooms.dart';
import 'package:tempo/models/rental_detail_models.dart';
import 'package:tempo/models/rental_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempo/widgets/satefull/text.dart';
import '../../models/rental_room_models.dart';

class RentalRoomPageDetails extends StatefulWidget {
  final RentalModel rentalModel;
  final RentalRoomModel rentalRoomModel;
  const RentalRoomPageDetails({
    Key? key,
    required this.rentalModel,
    required this.rentalRoomModel,
  }) : super(key: key);

  @override
  RentalRoomPageDetailsState createState() => RentalRoomPageDetailsState();
}

class RentalRoomPageDetailsState extends State<RentalRoomPageDetails> {
  RentalDetail? rentalDetail;
  final formater = NumberFormat.decimalPattern();
  late Dialog dialog;
  final fmt = DateFormat('kk:mm a dd-MM-yyyy');
  bool _isCopied = false;
  late FirebaseMessaging messaging;
  String? refCode;
  bool paidSuccessfully = false;
  bool hasReference = false;
  bool hasreceiptResponse = false;
  late double height, width;
  String? referenceNumber;
  bool _isCheckingPayments = true;

  @override
  void initState() {
    super.initState();
    _initRooms();
  }

  void _initRooms() {
    _isCheckingPayments = true;
    // httpCheckPaymentStatus(widget.rentalModel.houseId, _finisheChecking);

    httpLoadRentalRooms(widget.rentalModel.houseId, _finishedLoading);
  }

  _finishedLoading(bool isSuccess, String message) {}

  _finisheChecking(
      bool isSuccess, String message, RentalDetail rentalDetailData) {
    setState(() {
      _isCheckingPayments = false;
      rentalDetail = rentalDetailData;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
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
                  _loadThumbnails(),
                  _serviceIntro(),
                  _rentalDetails(),
                  _serviceDescriptions(),
                ],
              ),
            )));
  }

  Widget _loadThumbnails() {
    return CarouselSlider.builder(
      itemCount: widget.rentalRoomModel.roomThumbNails.isNotEmpty
          ? widget.rentalRoomModel.roomThumbNails.length
          : widget.rentalModel.thumbnails.length,
      options: CarouselOptions(
        enlargeCenterPage: true,
        height: 250,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        reverse: false,
        aspectRatio: 5.0,
      ),
      itemBuilder: (context, i, id) {
        //for onTap to redirect to another screen
        return Image.network(
          widget.rentalRoomModel.roomThumbNails.isNotEmpty
              ? widget.rentalRoomModel.roomThumbNails[i].imageuUrl
              : widget.rentalModel.thumbnails[i].imageuUrl,
          width: width,
          fit: BoxFit.cover,
        );
      },
    );
  }

  Widget _serviceDescriptions() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Text(widget.rentalModel.description,
          style: const TextStyle(fontSize: 18)),
    );
  }

  Widget _serviceIntro() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // ignore: deprecated_member_use
          const FaIcon(FontAwesomeIcons.mapMarkerAlt,
              color: Colors.amber, size: 16),
          const SizedBox(width: 10),
          Text(widget.rentalModel.region, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 10),
          Text(widget.rentalModel.district,
              style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  _rentalDetails() {
    return _isCheckingPayments? SizedBox(
              height: height * 0.5,
              child: const Center(
                child: SizedBox(
                    height: 50, width: 50, child: CircularProgressIndicator()),
              )):rentalDetail!.isPaid?
               _paidRental(rentalDetail!): _unpaidRental();
            }
      

  _paidRental(RentalDetail rentalDetail) {
    return Card(
      elevation: 5,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(children: [
            titleText('house_details', context),
            const SizedBox(height: 10),
            Card(
                color: Colors.blueAccent,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: Text(
                          'price_per_month'.tr,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        )),
                        Text(
                          '${widget.rentalRoomModel.price}.00TZS',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                      ],
                    )
                  ]),
                )),
            const SizedBox(
              height: 10,
            ),
            Card(
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: Text(
                          'payment_received'.tr,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        )),
                        IconButton(
                            icon: const Icon(Icons.check, color: Colors.green),
                            onPressed: requestReference),
                      ],
                    )
                  ]),
                )),
            const SizedBox(
              height: 10,
            ),
            Card(
              color: Colors.amber,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Text(
                      '${'street'.tr} : ${rentalDetail.street}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    )),
                  ],
                ),
              ),
            ),
            Card(
              color: Colors.amber,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Text(
                      '${'contact_phone'.tr} : ${rentalDetail.phone}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    )),
                    IconButton(
                        icon: const Icon(Icons.phone, color: Colors.black),
                        onPressed: dialPhoneFun),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 1),
            Card(
              color: Colors.amber,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Text(
                      '${'category'.tr} : ${rentalDetail.category}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    )),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 1),
            Card(
              color: Colors.amber,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Text(
                      // ignore: unnecessary_null_comparison
                      '${'map'.tr} : ${rentalDetail.map}' != null
                          ? 'view_map'.tr
                          : 'no_map'.tr,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    )),
                    IconButton(
                        icon: const Icon(Icons.location_on_outlined,
                            color: Colors.black),
                        onPressed: openMap),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            _houseDetails()
          ])),
    );
  }

  _unpaidRental() {
    return Card(
      elevation: 5,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(children: [
            titleText('house_details', context),
            const SizedBox(height: 10),
            // _requestReference(),
            const SizedBox(height: 10),
            Card(
              color: Colors.amber,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Text(
                      '${'street'.tr} : ${'no_data'.tr}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    )),
                  ],
                ),
              ),
            ),
            Card(
              color: Colors.amber,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Text(
                      '${'contact_phone'.tr} : ${'no_data'.tr}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    )),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 1),
            Card(
              color: Colors.amber,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Text(
                      '${'category'.tr} : ${'no_data'.tr}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    )),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 1),
            Card(
              color: Colors.amber,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Text(
                      '${'map'.tr} : ${'no_map'.tr}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    )),
                    IconButton(
                        icon: const Icon(Icons.location_off_outlined,
                            color: Colors.grey),
                        onPressed: openMap),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            _houseDetails()
          ])),
    );
  }

  _houseDetails() {
    return Center(
      child: Table(
        defaultColumnWidth: FixedColumnWidth((width / 2) - 5),
        border: TableBorder.all(
            color: Theme.of(context).primaryColor,
            style: BorderStyle.solid,
            width: 1),
        children: [
          TableRow(children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text('ideneity'.tr)),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(widget.rentalModel.identity)),
          ]),
          TableRow(children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text('water'.tr)),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(widget.rentalModel.water
                    ? 'available'.tr
                    : 'not_availble'.tr)),
          ]),
          TableRow(children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text('electricity'.tr)),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(widget.rentalModel.electricity
                    ? 'available'.tr
                    : 'not_availble'.tr)),
          ]),
          TableRow(children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text('transport'.tr)),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(widget.rentalModel.transport.contains('Public')
                    ? 'public_transport'.tr
                    : 'private_transport'.tr)),
          ]),
          TableRow(children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text('price_per_month'.tr)),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text('${widget.rentalRoomModel.price}.00TZS')),
          ]),
          TableRow(children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text('min_booking_months'.tr)),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(widget.rentalModel.months + 'months'.tr)),
          ]),
        ],
      ),
    );
  }

  // _requestReference() {
  //   return Card(
  //       color: Colors.green,
  //       elevation: 5,
  //       child: FutureBuilder<String>(
  //         builder: (context, snapshot) {
  //           if (snapshot.hasData) {
  //             if (snapshot.data != null) {
  //               referenceNumber = snapshot.data;
  //               return Padding(
  //                 padding:
  //                     const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //                 child: Column(children: [
  //                   titleSPText('payments', context, Colors.white),
  //                   const SizedBox(height: 5),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Flexible(
  //                           child: Text(
  //                         referenceNumber!,
  //                         style: const TextStyle(
  //                             fontSize: 15,
  //                             fontWeight: FontWeight.bold,
  //                             color: Colors.amber),
  //                         softWrap: true,
  //                         overflow: TextOverflow.fade,
  //                       )),
  //                       IconButton(
  //                           icon: _isCopied
  //                               ? const Icon(Icons.copy, color: Colors.amber)
  //                               : const Icon(Icons.copy_all,
  //                                   color: Colors.white),
  //                           onPressed: copyRefFn),
  //                     ],
  //                   ),
  //                   const SizedBox(height: 5),
  //                   Text('use_reference_to_pay'.tr,
  //                       style: const TextStyle(
  //                         fontSize: 15,
  //                         color: Colors.white,
  //                       )),
  //                 ]),
  //               );
  //             } else {
  //               return Card(
  //                 color: Colors.red,
  //                 child: Padding(
  //                   padding: const EdgeInsets.symmetric(
  //                       horizontal: 20, vertical: 10),
  //                   child: Column(children: [
  //                     Text(
  //                       'could_not_load'.tr,
  //                       style: const TextStyle(
  //                         fontSize: 15,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                     const SizedBox(
  //                       height: 10,
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Flexible(
  //                             child: Text(
  //                           'click_request'.tr,
  //                           style: const TextStyle(
  //                             fontSize: 15,
  //                             color: Colors.black,
  //                           ),
  //                           softWrap: true,
  //                           overflow: TextOverflow.fade,
  //                         )),
  //                         IconButton(
  //                             icon: _isCopied
  //                                 ? const Icon(Icons.change_circle_outlined,
  //                                     color: Colors.green)
  //                                 : const Icon(Icons.change_circle_outlined,
  //                                     color: Colors.black),
  //                             onPressed: requestReference),
  //                       ],
  //                     )
  //                   ]),
  //                 ),
  //               );
  //             }
  //           } else {
  //             return const SizedBox(
  //                 height: 80,
  //                 child: Center(
  //                   child: SizedBox(
  //                       height: 30,
  //                       width: 30,
  //                       child: CircularProgressIndicator()),
  //                 ));
  //           }
  //         },
  //         future: requestReferenceNumber(widget.rentalModel.houseId, true),
  //       ));
  // }

  void requestReference() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("requesting".tr),
    ));
  }

  void copyRefFn() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("copied".tr),
    ));
    setState(() {
      _isCopied = true;
      Clipboard.setData(ClipboardData(text: referenceNumber));
    });
  }

  void dialPhoneFun() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("dialing".tr),
    ));
    setState(() {
      _isCopied = true;
      Clipboard.setData(ClipboardData(text: referenceNumber));
    });
  }

  void openMap() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("you_are_opening".tr),
    ));
  }
}
