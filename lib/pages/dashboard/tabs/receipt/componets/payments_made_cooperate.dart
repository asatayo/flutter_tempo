import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:tempo/models/payment_model.dart';

class PaymentsMadeCooperate extends StatelessWidget {
  final PaymentModel paymentsModel;
  final Function notifyParent;

  const PaymentsMadeCooperate({Key? key, required this.paymentsModel, required this.notifyParent}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final formater = NumberFormat.decimalPattern();
    final fmt = DateFormat('kk:mm a dd-MM-yyyy');
    return Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
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
                          color: Colors.amberAccent,
                          spreadRadius: 3,
                          blurRadius: 10)
                    ])),
          ),
          Positioned(
            child: Container(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Card(
                color: Theme.of(context).canvasColor,
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
                            paymentsModel.category!,
                            textAlign: TextAlign.start,
                            style: const TextStyle(fontSize: 15),
                          ),
                          Text(
                            paymentsModel.serviceName!,
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
                            'quantity'.tr,
                            textAlign: TextAlign.start,
                            style: const TextStyle(fontSize: 15),
                          ),
                          Text(
                            paymentsModel.roomsCount!,
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
                            paymentsModel.isHouse? 'days'.tr :'hours'.tr,
                            textAlign: TextAlign.start,
                            style: const TextStyle(fontSize: 15),
                          ),
                          Text(
                            paymentsModel.duration!,
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
                            '${formater.format(double.parse(paymentsModel.amount!)*double.parse(paymentsModel.roomsCount!))}.00TZS',
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
                            'reference_number'.tr,
                            textAlign: TextAlign.start,
                            style: const TextStyle(fontSize: 15),
                          ),
                          Text(
                            paymentsModel.referenceNumber!,
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
                                .format(DateTime.parse(paymentsModel.entryDateTime!))
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
                            'exit_date'.tr,
                            textAlign: TextAlign.start,
                            style: const TextStyle(fontSize: 15),
                          ),
                          Text(
                            fmt
                                .format(DateTime.parse(paymentsModel.exitDateTime!))
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
}
