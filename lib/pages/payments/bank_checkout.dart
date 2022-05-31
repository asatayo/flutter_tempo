import 'dart:io';

import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:tempo/dialogs/snackbar.dart';
import 'package:tempo/models/payment_model.dart';
import 'package:tempo/pages/dashboard/dashboard_page.dart';
import 'package:tempo/pages/payments/http/http_payments.dart';
import 'package:tempo/pages/payments/success/pad_successfully.dart';
import 'package:tempo/preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:tempo/preferences/shared_prefs_fun.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CheckOutPage extends StatefulWidget {
  final String url;
  const CheckOutPage({Key? key, required this.url}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  CheckOutPageState createState() => CheckOutPageState(url:url);
}

class CheckOutPageState extends State<CheckOutPage> {
  bool isLoading = true;
  final _key = UniqueKey();
  late double height;
  late double width;
  final String url;
  CheckOutPageState({required this.url});

  @override
  void initState() {
    super.initState();
    checkCount = 0;
    // print(url);
    listenPayment();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  Future<void> listenPayment() async {
    String? reservationNumber =
        await AppData().getString('NEW_REFERENCE_NUMBER');
    var data = {
      'reservation_number': reservationNumber,
    };
    await checkStatus(data, isPaymentDone);
  }

  Future<void> isPaymentDone(
      bool isPaid, String message, String receipt) async {
    if (isPaid) {
      String? referenceNumber =
          await AppData().getString("NEW_REFERENCE_NUMBER");

      await storePaymentReceipt(receipt, referenceNumber!);

      await paymentCompleted(receipt);

      PaymentModel paymentModel = await paymentDataToModel();

      // ignore: use_build_context_synchronously
      Navigator.of(context).popUntil((route) => route.isFirst);

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => PaidSuccessfullyPage(
                    paymentModel: paymentModel,
                  )));
    } else {
      AppSnackBar(context: context).showSnackBar(message, 3);
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const DashboardPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined,
              color: Theme.of(context).textTheme.bodyText2!.color),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('selcom_portal'.tr,
            style:
                TextStyle(color: Theme.of(context).textTheme.bodyText2!.color)),
        backgroundColor: Theme.of(context).primaryColor,
      ),

      body: Stack(
        children: <Widget>[
          WebView(
            backgroundColor: Colors.white,
            key: _key,
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finish) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading
              ? Center(
                  child: Image.asset('assets/images/gif.gif', width: 250),
                )
              : Stack(),
        ],
      ),
      // body: Column(
      //   children: [
      //   Expanded(
      //       child: WebView(
      //           initialUrl: url,
      //           javascriptMode: JavascriptMode.unrestricted,
      //           )
      //           )
      // ]
      // )
    );
  }
}
