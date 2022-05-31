import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tempo/models/payment_model.dart';
import 'intructions.dart';

Widget bookSammary(BuildContext context, PaymentModel paymentModel) {
  
   final formater = NumberFormat.decimalPattern();
  final fmt = DateFormat('kk:mm a dd-MM-yyyy');
  
  return Container(
    color: Theme.of(context).primaryColor,
    padding: const EdgeInsets.all(5),
    child: Card(
        child: Column(
      children: [
        checkTitle('booking_summary', context),
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
                    fmt.format(DateTime.parse(paymentModel.entryDateTime!)).toString(),
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
                    fmt.format(DateTime.parse(paymentModel.exitDateTime!)).toString(),
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
                      Text(
                        paymentModel.isHouse? 'total_days'.tr : 'total_hours'.tr,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Text(
                    paymentModel.duration!,
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
                        'price'.tr,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Text(
                    '${formater.format(double.parse(paymentModel.price!))}.00TZS',
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
                  Text(
                      '${formater.format(double.parse(paymentModel.amount!))}.00TZS',
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
