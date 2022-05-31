import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tempo/http/http_reference.dart';
import 'package:tempo/models/rental_detail_models.dart';
import 'package:tempo/models/rental_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempo/pages/payments/checkout.dart';
import 'package:tempo/pages/rental/views/house_details.dart';
import 'package:tempo/pages/rental/views/reference_view.dart';
import 'package:tempo/pages/rental/views/unpaid_rental.dart';
import 'package:tempo/widgets/satefull/text.dart';


class RentalDetailsPage extends StatefulWidget {
  final RentalModel? rentalModel;
  final bool isAuthenticated;
  const RentalDetailsPage({
    Key? key,
    required this.rentalModel,
    required this.isAuthenticated,
  }) : super(key: key);

  @override
  RentalDetailsPageState createState() => RentalDetailsPageState();
}

class RentalDetailsPageState extends State<RentalDetailsPage> {
  final formater = NumberFormat.decimalPattern();
  late Dialog dialog;
  final fmt = DateFormat('kk:mm a dd-MM-yyyy');
  bool _isPaid = false;
  late FirebaseMessaging messaging;
  String? refCode;
  bool paidSuccessfully = false;
  bool hasReference = false;
  bool hasreceiptResponse = false;
  // bool _isLoadingRentalRooms = true;
  bool _isCheckingPayments = true;
  bool _isReference = false;
  late double height, width;
  String? referenceNumber;
  bool _isCopied = false;
  bool _isUpdate = false;

  @override
  void initState() {
    super.initState();
    _initRooms();
    // futureRentalRooms = getFutureRentalRooms(widget.rentalModel.houseId);
    // httpLoadRentalRooms(widget.rentalModel.houseId, _finishedLoading);
  }

  void _initRooms() {
    _isCheckingPayments = true;
    httpStatusCheck(
        widget.rentalModel!.houseId, false, _isUpdate, _finishedChecking);
  }

  _finishedChecking(bool isSuccess, isReference, isPaid, String reference) {
    if (isReference && _isUpdate) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const Payment(isRental: true)));
    } else {
      if (mounted) {
        setState(() {
          _isPaid = isPaid;
          _isCheckingPayments = false;
          _isReference = isReference;
        });
      }
    }
  }

  void _updateState() {
    setState(() {
      _isUpdate = true;
      _initRooms();
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
                        Text(widget.rentalModel!.name,
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
                  Image.network(
                    widget.rentalModel!.bannerThumbNail,
                    fit: BoxFit.cover,
                  ),
                  _serviceIntro(),
                  _rentalDetails(),
                  _serviceDescriptions(),
                ],
              ),
            )));
  }

  Widget _serviceDescriptions() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Text(widget.rentalModel!.description,
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
          Text(widget.rentalModel!.region,
              style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 10),
          Text(widget.rentalModel!.district,
              style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  _rentalDetails() {
    return _isCheckingPayments
        ? SizedBox(
            height: height * 0.5,
            child: const Center(
              child: SizedBox(
                  height: 50, width: 50, child: CircularProgressIndicator()),
            ))
        : _isReference
            ? refrenceView(context, widget.rentalModel!)
            : _isPaid
                ? paidRental(rentalDetailModel!)
                : unpaidRental(context, widget.rentalModel!, _updateState);
  }

  paidRental(RentalDetail rentalDetailModel) {
    return Card(
      elevation: 5,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(children: [
            titleText('house_details'.tr, context),
            const SizedBox(height: 10),
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
                        const Icon(Icons.check, color: Colors.green),
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
                      '${'street'.tr} : ${rentalDetailModel.street}',
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
                      // ignore: unnecessary_null_comparison
                      '${'contact_phone'.tr} : ${rentalDetailModel.phone}' !=
                              null
                          ? rentalDetailModel.phone
                          : 'no_phone'.tr,
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
                      '${'category'.tr} : ${rentalDetailModel.category}',
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
                      '${'map'.tr} : ${rentalDetailModel.map}' != null
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
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("you_are_opening".tr),
                          ));
                        }),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            houseDetails(context, widget.rentalModel!)
          ])),
    );
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
}
