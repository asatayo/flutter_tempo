import 'package:flutter/material.dart';
import 'package:tempo/models/payment_model.dart';
import 'package:tempo/pages/payments/execution/payment_details.dart';
import 'package:tempo/preferences/shared_prefs_fun.dart';
class ReceiptCheck {
  static initCheck(BuildContext context) async {
  PaymentModel paymentModel = await paymentDataToModel();
   bool isWaiting = await isWaitingForPayment();
    if(isWaiting){
    // ignore: use_build_context_synchronously
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PaymentsPage(paymentModel: paymentModel)));
    }
  }
}
