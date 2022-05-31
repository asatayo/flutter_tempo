import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:tempo/models/room_models.dart';
import 'package:tempo/models/services.dart';
import 'package:tempo/models/thumbnail_model.dart';
import 'package:tempo/pages/payments/checkout.dart';
import 'package:tempo/pages/payments/cooperate/cooperate_page.dart';
import 'package:tempo/preferences/shared_preferences.dart';
import 'package:tempo/utils/prefs.dart';
import 'package:tempo/widgets/stateless/photo_thumbnail.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';

import '../../models/rental_model.dart';

class RentalBookingPage extends StatefulWidget {
  final bool isHouse;
  final ServiceModel serviceModel;
  final RoomModel roomModel;
  final RentalModel rentalModel;

  const RentalBookingPage({
    Key? key,
    required this.isHouse,
    required this.serviceModel,
    required this.roomModel,
    required this.rentalModel,
  }) : super(key: key);

  @override
  RentalBookingPageState createState() => RentalBookingPageState();
}

class RentalBookingPageState extends State<RentalBookingPage> {
  String _entryDateTime =
      DateFormat('kk:mm a dd-MM-yyyy').format(DateTime.now());
  String _exitDateTime =
      DateFormat('kk:mm a dd-MM-yyyy').format(DateTime.now());
  String _cleanEntryDateTime = DateTime.now().toString();
  String _cleanExitDateTime = DateTime.now().toString();
  DateTime _fromDate = DateTime.now();
  DateTime _toDate = DateTime.now();
  int _hoursOrDays = 0;
  int _comparisonData = 0;
  double _totalAmount = 0;
  bool _isCooperate = false;
  final formater = NumberFormat.decimalPattern();

  @override
  void initState() {
    super.initState();
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
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined,
                color: Theme.of(context).textTheme.bodyText2!.color),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
              widget.isHouse
                  ? widget.rentalModel.name
                  : widget.roomModel.roomName,
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText2!.color)),
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                _loadThumbnails(
                    context,
                    widget.isHouse
                        ? widget.rentalModel.thumbnails
                        : widget.roomModel.roomThumbNails),
                        !widget.isHouse?_bookingType(context): const SizedBox(height: 1.0),
                _checkDate(context),
                _bookingSummary(context),
              ],
            ),
            Positioned(bottom: 10, child: _bookButton())
          ],
        ),
      ),
    );
  }

  Widget _loadThumbnails(
      BuildContext context, List<ThumbnailModel> thumbnails) {
    String thumbnail;
    return Container(
      color: Theme.of(context).primaryColor,
      height: MediaQuery.of(context).size.height / 5,
      child: thumbnails.isNotEmpty
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: thumbnails.length,
              itemBuilder: (BuildContext context, int index) {
                thumbnail = thumbnails[index].imageuUrl;
                return PhotoThumbnailAdapter(imageUrl: thumbnail);
              })
          : Center(child: Text(
        'no_thumbnails'.tr,
        style: const TextStyle(fontSize: 16),
      ),),
    );
  }

  Widget _bookingType(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.all(10),
      child: Card(
          child: Column(
        children: <Widget>[
           _checkTitle('booking_type'),
          ListTile(
            title:  Text('personal_booking'.tr),
            leading: Radio<bool>(
              value: false,
              groupValue: _isCooperate,
              onChanged: (value) async {
                setState(() {
                  _isCooperate = value!;
                });
              },
            ),
          ),
          ListTile(
            title:  Text('cooperate_booking'.tr),
            leading: Radio<bool>(
              value: true,
              groupValue: _isCooperate,
              onChanged: (value) {
                setState(() {
                  _isCooperate = value!;
                });
              },
            ),
          ),
        ],
      )),
    );
  }

  Widget _checkDate(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.all(10),
      child: Card(
          child: Column(
        children: [
          _checkInDate(),
          const SizedBox(height: 10),
          _checkOutDate(),
        ],
      )),
    );
  }

  Widget _checkInDate() {
    return Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(children: [
          _checkTitle('check_in'),
          DateTimePicker(
            // locale: const Locale("sw", "TZ"),
            type: widget.isHouse
                ? DateTimePickerType.date
                : DateTimePickerType.dateTimeSeparate,
            dateMask: 'd MMM, yyyy',
            initialValue: DateTime.now().toString(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
            icon: const Icon(Icons.event),
            dateLabelText: 'date'.tr,
            timeLabelText: "hour".tr,
            // timePickerEntryModeInput: !widget.isHouse,
            // use24HourFormat: false,
            selectableDayPredicate: (date) {
              return true;
            },
            onChanged: (val) {
              _updateStatus(val, false);
            },
            validator: (val) {
              // print(val);
              return null;
            },
            // ignore: avoid_print
            onSaved: (val) => print(val),
          ),
        ]));
  }

  _checkTitle(String title) {
    return SizedBox(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.only(right: 10),
                width: MediaQuery.of(context).size.width * 0.1,
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: Theme.of(context).textTheme.bodyText2!.color,
                )),
            Text(
              title.tr,
              style: const TextStyle(fontSize: 16),
            ),
            Container(
                margin: const EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width * 0.1,
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: Theme.of(context).textTheme.bodyText2!.color,
                )),
          ],
        ));
  }

  Widget _checkOutDate() {
    return Container(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: Column(children: [
          _checkTitle('check_out'),
          DateTimePicker(
            // locale: const Locale("sw", "TZ"),
            type: widget.isHouse
                ? DateTimePickerType.date
                : DateTimePickerType.dateTimeSeparate,
            dateMask: 'd MMM, yyyy',
            initialValue: DateTime.now().toString(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
            icon: const Icon(Icons.event),
            dateLabelText: 'date'.tr,
            timeLabelText: "hour".tr,
            // timePickerEntryModeInput: !widget.isHouse,
            // use24HourFormat: false,
            selectableDayPredicate: (date) {
              return true;
            },
            onChanged: (val) {
              _updateStatus(val, true);
            },
            validator: (val) {
              // print(val);
              return null;
            },
            // ignore: avoid_print
            onSaved: (val) => print(val),
          ),
        ]));
  }

  _updateStatus(String val, bool isTodate) {
    setState(() {
      Prefs.deleteData('reference');
      if (isTodate) {
        _toDate = DateTime.parse(val);
        _exitDateTime = widget.isHouse
            ? DateFormat('dd-MM-yyyy').format(_toDate)
            : DateFormat('hh:mm a dd-MM-yyyy').format(_toDate);

        _cleanExitDateTime = val;
      } else {
        _fromDate = DateTime.parse(val);
        _entryDateTime = widget.isHouse
            ? DateFormat('dd-MM-yyyy').format(_fromDate)
            : DateFormat('hh:mm a dd-MM-yyyy').format(_fromDate);

        _cleanEntryDateTime = val;
      }

      _hoursOrDays =
          _differenceInDaysOrHours(_fromDate, _toDate, widget.isHouse);

      _comparisonData = widget.isHouse
          ? int.parse(widget.rentalModel.months)
          : int.parse(widget.roomModel.hours);

      if (_hoursOrDays < _comparisonData) {
        String monthsOrHours = widget.isHouse ? 'months_jm'.tr : 'hours_jm'.tr;
        String minimum =
            widget.isHouse ? "minimum_months".tr : "minimum_hours".tr;
        String message = minimum + _comparisonData.toString() + monthsOrHours;

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(children: [
            Text(message),
          ]),
        ));
      }
      _hoursOrDays = _hoursOrDays >= 0 ? _hoursOrDays : 0;

      _totalAmount = _hoursOrDays *
          double.parse(widget.isHouse
              ? widget.rentalModel.price
              : widget.roomModel.price);
    });
  }

  int _differenceInDaysOrHours(DateTime from, DateTime to, bool isHouse) {
    int calculatedDeff = 0;
    try {
      if (isHouse) {
        // from = DateTime(from.year, from.month, from.day);
        // to = DateTime(to.year, to.month, to.day);
        // return (to.difference(from).inHours / 24).round();
        from = DateTime(from.year, from.month, from.day, from.hour);
        to = DateTime(to.year, to.month, to.day, to.hour);
        double diffrence = to.difference(from).inHours / 24;
        // print(diffrence);
        //  calculatedDeff= 3;
        if (diffrence > 0) {
          calculatedDeff = int.parse(diffrence.toStringAsFixed(0));
        }
        // from = DateTime(from.year, from.month, from.day, from.hour);
        // to = DateTime(to.year, to.month, to.day, to.hour);
        // calculatedDeff = (to.difference(from).inHours).round();
      } else {
        from = DateTime(from.year, from.month, from.day, from.hour);
        to = DateTime(to.year, to.month, to.day, to.hour);
        calculatedDeff = (to.difference(from).inHours).round();
      }
    } catch (ex) {
      // print(ex);
    }
    return calculatedDeff;
  }

  Widget _bookingSummary(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.all(5),
      child: Card(
          child: Column(
        children: [
          _checkTitle('booking_summary'),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.login),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'entry_date'.tr,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Text(
                      _entryDateTime,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(height: 1),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.logout),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'exit_date'.tr,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Text(
                      _exitDateTime,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(height: 1),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.timer),
                        const SizedBox(
                          width: 10,
                        ),
                        widget.isHouse
                            ? Text(
                                'total_months'.tr,
                                style: const TextStyle(fontSize: 16),
                              )
                            : Text(
                                'total_hours'.tr,
                                style: const TextStyle(fontSize: 16),
                              ),
                      ],
                    ),
                    Text(
                      _hoursOrDays.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(height: 1),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.money),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.isHouse
                              ? 'price_per_day'.tr
                              : 'price_per_hour'.tr,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Text(
                      '${formater
                              .format(double.parse(widget.isHouse
                                  ? widget.rentalModel.price
                                  : widget.roomModel.price))}.00TZS',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(height: 2),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.money),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('total'.tr,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Text('${formater.format(_totalAmount)}.00TZS',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(
                  height: 120,
                ),
              ],
            ),
          )
        ],
      )),
    );
  }

  Widget _bookButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
      child: InkWell(
        onTap: () async {
          if (_hoursOrDays >= _comparisonData && _hoursOrDays != 0) {
            await _keepPrefs();
            if(_isCooperate){
               // ignore: use_build_context_synchronously
               Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CooperatePage()));
              
            }else{
              // ignore: use_build_context_synchronously
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Payment(isRental: false)));
            }
           
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Row(children: [
                Text('choose_duration'.tr),
              ]),
            ));
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: _hoursOrDays >= _comparisonData && _hoursOrDays != 0
                ? Colors.amber
                : Colors.grey,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('continue'.tr,
                  style: const TextStyle(color: Colors.black, fontSize: 16)),
              const SizedBox(width: 10),
              const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.black,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _keepPrefs() async {
    AppData().removeData("NEW_REFERENCE_NUMBER");
    await AppData().storeValue('BOOKING_TOTAL', _totalAmount.toString());
    await AppData().storeValue('BOOKING_ENTRY_DATE', _cleanEntryDateTime);
    await AppData().storeValue('IS_COOPERATE', _isCooperate);
    await AppData().storeValue('BOOKING_EXITDATE', _cleanExitDateTime);
    await AppData().storeValue('BOOKING_DURATION', _hoursOrDays.toString());
  }
}
