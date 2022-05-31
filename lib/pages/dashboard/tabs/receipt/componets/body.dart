import 'package:flutter/material.dart';
import 'package:tempo/models/payment_model.dart';
import 'package:tempo/pages/dashboard/tabs/receipt/componets/payments_made.dart';
import 'package:tempo/pages/dashboard/tabs/receipt/componets/payments_made_cooperate.dart';
import 'package:tempo/preferences/shared_prefs_fun.dart';
import 'no_payment.dart';

class Body extends StatelessWidget {
  final Function notifyParent;
  const Body({Key? key, required this.notifyParent}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      FutureBuilder<PaymentModel>(
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            PaymentModel paymentModel = snapshot.data!;
            // print("Is payment model is ${paymentModel.receiptNumber}");

            // ignore: unnecessary_null_comparison
            if (paymentModel.isPaid) {
              if (paymentModel.isCooperate) {
                return Center(
                  child: PaymentsMadeCooperate(
                      notifyParent: notifyParent, paymentsModel: paymentModel),
                );
              } else {
                return Center(
                  child: PaymentsMade(
                      notifyParent: notifyParent, paymentsModel: paymentModel),
                );
              }
            } else {
              return Center(
                child: NoPaymentMade(notifyParent: notifyParent),
              );
            }
          } else {
            return Center(
              child: NoPaymentMade(notifyParent: notifyParent),
            );
          }
        },
        future: paymentDataToModel(),
      )
    ]);
  }
}
