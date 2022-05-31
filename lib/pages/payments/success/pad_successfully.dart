import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tempo/models/payment_model.dart';
import 'package:tempo/pages/dashboard/dashboard_page.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PaidSuccessfullyPage extends StatefulWidget {
  final PaymentModel paymentModel;

    const PaidSuccessfullyPage({Key? key, @required required this.paymentModel}) : super(key: key);

  // const PaidSuccessfullyPage({
  //   Key key, required this.paymentModel,
  // }) : super(key: key);

  @override
  PaidSuccessfullyPageState createState() => PaidSuccessfullyPageState();
}

class PaidSuccessfullyPageState extends State<PaidSuccessfullyPage> {
  final formater = NumberFormat.decimalPattern();
  late Dialog dialog;
  final fmt = DateFormat('kk:mm a dd-MM-yyyy');
  late FirebaseMessaging messaging;

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
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined,
                color: Theme.of(context).textTheme.bodyText2!.color),
            onPressed: _moveToDashboard,
          ),
          title: Text(
              widget.paymentModel.isHouse
                  ? widget.paymentModel.houseName!
                  : widget.paymentModel.roomName!,
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText2!.color)),
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                _paymentsMade(context),
                // _statusBody(context),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
            Positioned(bottom: 10, child: _okButton())
          ],
        ),
      ),
    );
  }

  Widget _paymentsMade(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 2, right: 2, top: 20),
        child: Stack(children: [
          Positioned(
            child: Container(
                height: 10,
                decoration: BoxDecoration(
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border:
                        Border.all(color: Theme.of(context).backgroundColor),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.amber, spreadRadius: 2, blurRadius: 3)
                    ])),
          ),
          Positioned(
            child: Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(0),
                        topLeft: Radius.circular(0),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        // ignore: deprecated_member_use
                        child: FaIcon(FontAwesomeIcons.checkCircle,
                            size: 50, color: Colors.green),
                      ),
                      const SizedBox(height: 10),
                      Text('your_purchase_was_successfully'.tr,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Text(
                        'payment_made_successfully'.tr,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'summary'.tr,
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.paymentModel.category!,
                            textAlign: TextAlign.start,
                            style: const TextStyle(fontSize: 15),
                          ),
                          Text(
                            widget.paymentModel.isHouse
                                ? widget.paymentModel.houseName!
                                : widget.paymentModel.serviceName!,
                            textAlign: TextAlign.start,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Divider(),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.paymentModel.isHouse
                                ? 'days'.tr
                                : 'hours'.tr,
                            textAlign: TextAlign.start,
                            style: const TextStyle(fontSize: 15),
                          ),
                          Text(
                            widget.paymentModel.duration!,
                            textAlign: TextAlign.start,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Divider(),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'amount'.tr,
                            textAlign: TextAlign.start,
                            style: const TextStyle(fontSize: 15),
                          ),
                          Text(
                            '${formater.format(double.parse(widget.paymentModel.amount!))}.00TZS',
                            textAlign: TextAlign.start,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Divider(),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'receipt'.tr,
                            textAlign: TextAlign.start,
                            style: const TextStyle(fontSize: 15),
                          ),
                          Text(
                            widget.paymentModel.receiptNumber!,
                            textAlign: TextAlign.start,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Divider(),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'entry_date'.tr,
                            textAlign: TextAlign.start,
                            style: const TextStyle(fontSize: 15),
                          ),
                          Text(
                            fmt
                                .format(DateTime.parse(
                                    widget.paymentModel.entryDateTime!))
                                .toString(),
                            textAlign: TextAlign.start,
                            style: const TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Divider(),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'entry_date'.tr,
                            textAlign: TextAlign.start,
                            style: const TextStyle(fontSize: 15),
                          ),
                          Text(
                            fmt
                                .format(DateTime.parse(
                                    widget.paymentModel.exitDateTime!))
                                .toString(),
                            textAlign: TextAlign.start,
                            style: const TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          )
        ]));
  }

  Widget paymentReference() {
    return Container(
        padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
        child: Column(children: [
          const FaIcon(Icons.check_circle_rounded),
          const SizedBox(height: 10),
          const Divider(
            height: 1,
          ),
          const SizedBox(height: 5),
          _paymentDescription(widget.paymentModel.operatorType!),
          const SizedBox(height: 20),
        ]));
  }

  Widget _okButton() {
    return Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
            child: InkWell(
              onTap: () {
                _moveToDashboard();
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('ok'.tr,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18)),
                    const SizedBox(width: 10),
                    const Icon(
                      FontAwesomeIcons.thumbsUp,
                      color: Colors.black,
                      size: 22,
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  _paymentDescription(String option) {
    switch (option) {
      case 'M-PESA':
        return Column(
          children: [
            const SizedBox(height: 10),
            Text(
              'mpesa_guide'.tr,
              style: const TextStyle(fontSize: 20, height: 1.5),
            ),
          ],
        );
      default:
        return Column(
          children: [
            const SizedBox(height: 10),
            Text(
              'mpesa_guide'.tr,
              style: const TextStyle(fontSize: 20, height: 1.5),
            ),
          ],
        );
    }
  }

  _moveToDashboard() {
    currentIndexPage = 2;
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const DashboardPage()), (route) => false);
    
  }
}
