import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:tempo/builders/http/reference_builder.dart';
import 'package:tempo/constants/constants.dart';
import 'package:tempo/dialogs/dialog.dart';
import 'package:tempo/dialogs/snackbar.dart';
import 'package:tempo/http/api.dart';
import 'package:tempo/models/payment_model.dart';
import 'package:tempo/models/rental_model.dart';
import 'package:tempo/pages/dashboard/dashboard_page.dart';
import 'package:tempo/pages/dashboard/tabs/menu_tab.dart';
import 'package:tempo/pages/payments/bank_checkout.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tempo/pages/payments/http/http_payments.dart';
import 'package:tempo/pages/payments/success/pad_successfully.dart';
import 'package:tempo/pages/rental/rental_details/rental_details_page.dart';
import 'package:tempo/preferences/shared_preferences.dart';
import 'package:tempo/preferences/shared_prefs_fun.dart';

int checkCount = 0;

class Payment extends StatefulWidget {
  final bool isRental;

  const Payment({Key? key, required this.isRental}) : super(key: key);

  @override
  PaymentState createState() => PaymentState();
}

class PaymentState extends State<Payment> {
  late double height;
  late double width;
  double total = 0;
  bool isMobilePayment = true;
  bool isBankPayments = false;
  bool isCompleted = false;
  String _paymentOperator = "Mobile";
  bool _hasDialog = false;

  // bool __isLoadingLocation = false;
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
    height = MediaQuery.of(context).size.height - 140;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined,
              color: Theme.of(context).textTheme.bodyText2!.color),
          onPressed: () {
            if (isCompleted) {
              //  AppSnackBar(context: context).showSnackBar(message, 3);
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DashboardPage()));
              //  Navigator.of(context).pushAndRemoveUntil(
              //   MaterialPageRoute(
              //       builder: (context) => const CustomerDashboard()),
              //   (route) => false);
            } else {
              // Navigator.of(context).pushAndRemoveUntil(
              //   MaterialPageRoute(
              //       builder: (context) => const CustomerDashboard()),
              //   (route) => false);
              AppSnackBar(context: context)
                  .showSnackBar("Payment is cancelled", 3);
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DashboardPage()));
            }
          },
        ),
        title: Text('payment_methods'.tr,
            style:
                TextStyle(color: Theme.of(context).textTheme.bodyText2!.color)),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            customerPayment(),
            azamPay(),
            //  confirmButton()
          ],
        ),
      ),
      bottomSheet: confirmButton(),
    ));
  }

  customerPayment() {
    return Padding(
        padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
        child: Column(
          children: [
            Stack(children: [
              InkWell(
                  onTap: () {
                    updateOption("MOBILE");
                  },
                  child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        width: width - 30,
                        height: width * 0.26,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                              image: AssetImage(
                                  'assets/images/payments/mobile.png'),
                              fit: BoxFit.fill),
                        ),
                      ))),
              Positioned(
                  right: 0,
                  child: isMobilePayment
                      ? Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryColor,
                            border: Border.all(color: Colors.white, width: 1),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.blueAccent,
                                spreadRadius: 1,
                                blurRadius: 3,
                              ),
                            ],
                          ),
                          height: 20,
                          width: 20,
                          child: const Icon(
                            Icons.check_outlined,
                            color: Colors.white,
                            size: 15,
                          ),
                        )
                      : const SizedBox(height: 20))
            ]),
            const SizedBox(
              height: 20,
            ),
            Stack(children: [
              InkWell(
                  onTap: () {
                    updateOption("BANK");
                  },
                  child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        width: width - 30,
                        height: width * 0.26,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                              image:
                                  AssetImage('assets/images/payments/bank.png'),
                              fit: BoxFit.fill),
                        ),
                      ))),
              Positioned(
                  right: 0,
                  child: isBankPayments
                      ? Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryColor,
                            border: Border.all(color: Colors.white, width: 1),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.blueAccent,
                                spreadRadius: 1,
                                blurRadius: 3,
                              ),
                            ],
                          ),
                          height: 20,
                          width: 20,
                          child: const Icon(
                            Icons.check_outlined,
                            color: Colors.white,
                            size: 15,
                          ),
                        )
                      : const SizedBox(height: 15))
            ]),
          ],
        ));
  }

  void updateOption(String option) {
    setState(() {
      if (option == "MOBILE") {
        isMobilePayment = true;
        isBankPayments = false;
        _paymentOperator = "Mobile";
      } else {
        isMobilePayment = false;
        isBankPayments = true;
        _paymentOperator = "Bank";
      }
    });
  }

  azamPay() {
    return Padding(
        padding: const EdgeInsets.only(left: 20, top: 50, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //  Text("This payment is secured by Selcom Pay", style: black16MediumTextStyle,),

            const SizedBox(
              height: 10,
            ),
            Image.asset(
              'assets/images/payments/selcom.png',
              height: 50,
            ),
          ],
        ));
  }

  confirmButton() {
    return Padding(
        padding:
            const EdgeInsets.only(left: 20, top: 10, bottom: 20, right: 20),
        child: InkWell(
            onTap: () async {
              if (widget.isRental) {
                String? reservation =
                    await AppData().getString('RENTAL_REFERENCE_NUMBER');

                if (reservation != null) {
                  // ignore: use_build_context_synchronously
                  AppDialogView(title: "Processing order...")
                      .loadingDialogView(context);

                  if (isBankPayments) {
                    processCheckout(reservation);
                  } else {
                    processUSSD(reservation);
                  }
                } else {
                  String message =
                      "Reference number was not created please try to generate again";
                  AppSnackBar(context: context).showSnackBar(message, 8);
                }
              } else {
                _requestRefNumber();
              }
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
                  Text('continue'.tr,
                      style:
                          const TextStyle(color: Colors.black, fontSize: 16)),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.black,
                    size: 20,
                  ),
                ],
              ),
            )));
  }

  Future<void> _requestRefNumber() async {
    _hasDialog = true;

    AppDialogView(title: "Generating reservation...")
        .loadingDialogView(context);

    PaymentModel paymentModel = await _storeDataToPref();

    await sendHttpRequest(paymentModel, finishedLoading);
  }

  void finishedLoading(bool status, String reservation) {
    // print(invoice);
    if (status) {
      checkCount = 0;
      if (_hasDialog) {
        Navigator.pop(context);
        _hasDialog = false;
      }
      AppDialogView(title: "Processing order...").loadingDialogView(context);

      if (isBankPayments) {
        processCheckout(reservation);
      } else {
        processUSSD(reservation);
      }
    }
  }

  Future<PaymentModel> _storeDataToPref() async {
    await AppData().storeValue('BOOKING_OPERATOR', "MOBILE");
    await AppData().storeValue('BOOKING_USSD', "USSD");
    PaymentModel paymentModel = await paymentDataToModel();
    // print(paymentModel.length);
    //  print(paymentModel.first.price);
    return Future.value(paymentModel);
  }

  processUSSD(String reservation) async {
    var data = {
      "reservation_number": reservation,
      "operator": _paymentOperator,
    };

    _hasDialog = true;

    // print("Finished processing");
    await initiatePayments(data, _httpStaStatus);
  }

  processCheckout(String reservation) async {
    var data = {
      'reservation_number': reservation,
      "operator": _paymentOperator,
    };

    //  print("Finished processing");
    checkCount = 0;
    _hasDialog = true;

    await httpCheckout(data, finishCheckout);
  }

  Future<void> _httpStaStatus(bool status, String type) async {
    // print("USSD code is done");
    if (_hasDialog) {
      Navigator.pop(context);
      _hasDialog = false;
    }

    if (type == successType) {
      AppDialogView(title: "Confirm request sent to you")
          .paymentDialog(context, onCancell);

      _hasDialog = true;
      String? reservationNumber;
      if (widget.isRental) {
        reservationNumber =
            await AppData().getString('RENTAL_REFERENCE_NUMBER');
      } else {
        reservationNumber = await AppData().getString('NEW_REFERENCE_NUMBER');
      }

      var data = {
        'reservation_number': reservationNumber,
      };
      await checkStatus(data, isPaymentDone);
    } else {
      bottomDialog();
    }
  }

  void onCancell() {
    checkCount = 0;
    if (_hasDialog) {
      Navigator.pop(context);
      _hasDialog = false;
    }
  }

  Future<void> finishCheckout(bool status, String url) async {
    // print("URL GENERATED code is done");
    if (_hasDialog) {
      Navigator.pop(context);
      _hasDialog = false;
    }

    if (status) {
      _storeCount();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CheckOutPage(url: url)));
    } else {
      String message = "Sorry payment could not be processed";
      AppSnackBar(context: context).showSnackBar(message, 5);
    }
  }

  Future<void> _storeCount() async {
    await AppData().storeValue('cartCount', 0);
  }

  Future<void> isPaymentDone(
      bool isPaid, String message, String receipt) async {
    if (isPaid) {
      if (widget.isRental ) {
      
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => RentalDetailsPage(
                      rentalModel: selectedModel,
                      isAuthenticated: true,
                    )));
      } else {
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
      }
    } else {
      AppSnackBar(context: context).showSnackBar(message, 3);
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const DashboardPage()));
    }
  }

  bottomDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: whiteColor,
          child: Wrap(
            children: <Widget>[
              Center(
                  child: Container(
                padding: const EdgeInsets.all(fixPadding * 2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    heightSpace,
                    heightSpace,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const <Widget>[
                        Icon(
                          // ignore: deprecated_member_use
                          FontAwesomeIcons.sadCry,
                          color: primaryColor,
                          size: 50.0,
                        ),
                        widthSpace,
                        widthSpace,
                      ],
                    ),
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    Text(
                      httpResponseMessage,
                      textAlign: TextAlign.center,
                      style: black15SemiBoldTextStyle,
                    ),
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    InkWell(
                        onTap: () async {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(fixPadding * 1.2),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                ),
                              ],
                            ),
                            child: Text(
                              'OK',
                              style: black18BoldTextStyle,
                            ),
                          ),
                        )),
                  ],
                ),
              ))
            ],
          ),
        );
      },
    );
  }
}
