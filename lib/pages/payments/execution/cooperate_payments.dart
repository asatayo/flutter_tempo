import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tempo/builders/check_receipt_builder.dart';
import 'package:tempo/builders/http/check_booking.dart';
import 'package:tempo/models/payment_model.dart';
import 'package:tempo/pages/dashboard/dashboard_page.dart';
import 'package:tempo/pages/payments/success/pad_successfully.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tempo/preferences/shared_preferences.dart';
import 'package:tempo/preferences/shared_prefs_fun.dart';
import 'components/dialog.dart';
import 'components/widgets/check_book_summary.dart';
import 'components/widgets/cooperate_instructions.dart';
import 'components/widgets/loading_status.dart';

class CooperatePaymentsPage extends StatefulWidget {
  final PaymentModel paymentModel;
  const CooperatePaymentsPage({
    Key? key,
    required this.paymentModel,
  }) : super(key: key);
  @override
  CooperatePaymentsPageState createState() => CooperatePaymentsPageState();
}

class CooperatePaymentsPageState extends State<CooperatePaymentsPage> {
  final formater = NumberFormat.decimalPattern();
  late Dialog dialog;
  final fmt = DateFormat('kk:mm a dd-MM-yyyy');
  bool _isCopied = false;
  bool _isLoading = false;
  late FirebaseMessaging messaging;
  String? _paymentRefNumber;
  String? refCode;
  bool paidSuccessfully = false;
  bool hasReference = false;
  bool hasreceiptResponse = false;
  String receiptResponseMessage = " ";
  @override
  void initState() {
    _checkWaiting();

    _listenFromFirebase(context);
   
    if (!hasReference) {
      _requestRefNumberHttp();
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _checkWaiting() async {
     bool isWaiting = await isWaitingForPayment();
    setState(() {
      // _isLoading = AppData().getBool('ISWAITING') ?? false;
      if (isWaiting) {
        _checkOnline(context);
      }
    });
  }

  void _listenFromFirebase(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) async {
      String receipt = event.data['receipt'];
      String referenceNumber = event.data['reference'];
      if (referenceNumber == _paymentRefNumber && _isLoading) {
        try {
          await storePaymentReceipt(receipt, referenceNumber);
          widget.paymentModel.setReceiptNumber = receipt;
                    await paymentCompleted(receipt);

          // ignore: use_build_context_synchronously
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PaidSuccessfullyPage(paymentModel: widget.paymentModel)));
        } catch (ex) {
          // print(ex);
        }
      }
    });
  }

  Future<void> _checkOnline(BuildContext context) async {
    String? referenceNumber = await AppData().getString('NEW_REFERENCE_NUMBER');
    String receipt =
        await getPaymentReceipt(referenceNumber!, widget.paymentModel.isHouse);
    if (receipt.isNotEmpty && receipt.length == 20) {
      await storePaymentReceipt(receipt, referenceNumber);
       await paymentCompleted(receipt);
    } else {
      if (receipt.isNotEmpty) {
        
        setState(() {
          hasreceiptResponse = true;
          receiptResponseMessage = receipt;
        });
      }
    }
  }

  Future<void> _requestRefNumberHttp() async {
     bool isWaitingForPay = await isWaitingForPayment();
     if(!isWaitingForPay){
      var refNumber = await sendCheckHttpRequest(widget.paymentModel);
      await AppData().storeValue('BOOKING_REFERENCE_NUMBER', refNumber);
    setState(() {
      hasReference = true;
      _paymentRefNumber = refNumber;

    });
     }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WillPopScope(
          onWillPop: () async {
              return true;
            },
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Theme.of(context).primaryColor,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios_outlined,
                        color: Theme.of(context).textTheme.bodyText2!.color),
                    onPressed: () => _isLoading
                        ? confirmDialog(context, yesCallBackFun, noCallBackFun)
                        : Navigator.pop(context),
                  ),
                  title: Text(
                      widget.paymentModel.isHouse
                          ? widget.paymentModel.houseName!
                          : "${widget.paymentModel.serviceName} | ${widget.paymentModel.roomName}",
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText2!.color)),
                ),
                body: Stack(
                  children: [
                    ListView(
                      children: [
                        checkInstructions(
                            context,
                            hasreceiptResponse,
                            receiptResponseMessage,
                            hasReference,
                            _paymentRefNumber,
                            _isCopied,
                            copyCallBackFun,
                            tryCallBackFun,
                            widget.paymentModel.cooperateNumber!),
                        _statusBody(context, widget.paymentModel),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                    _paymentRefNumber != null && _paymentRefNumber!.length == 21
                        ? Positioned(bottom: 10, child: _bookButton())
                        : Positioned(bottom: 10, child: _goBackBututon())
                  ],
                ))));
  }

  void callBackFn() {
    setState(() {
      confirmDialog(context, yesCallBackFun, noCallBackFun);
    });
  }

  void tryCallBackFun() {
    setState(() {
      _isLoading = true;
      _checkOnline(context);
    });
  }

  void noCallBackFun() {
    Navigator.pop(context);
    setState(() {});
  }

  yesCallBackFun() async {
    await AppData().storeValue("ISWAITING_PAYMENTS", false);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    setState(() {
      _isLoading = false;
    });
  }

  void copyCallBackFun() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("copied".tr),
    ));
    setState(() {
      _isCopied = true;
      Clipboard.setData(ClipboardData(text: _paymentRefNumber));
    });
  }

  Widget _statusBody(BuildContext context, PaymentModel paymentModel) {
    return _isLoading
        ? loadingStatus(context, callBackFn)
        : checkbookSammary(context, paymentModel);
  }

  Widget _bookButton() {
    return _isLoading
        ? const SizedBox(height: 50)
        : Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
            child: InkWell(
              onTap: () async {
                await AppData().storeValue("ISWAITING_PAYMENTS", false);
                // ignore: use_build_context_synchronously
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    builder: (context) =>
                        const DashboardPage()), (route) => false);
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
                    Text(
                      'ok'.tr,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.check,
                        color: Colors.black, size: 18),
                  ],
                ),
              ),
            ),
          );
  }

  Widget _goBackBututon() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
      child: InkWell(
        onTap: () async {
              await AppData().storeValue("ISWAITING_PAYMENTS", false);
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.arrow_back_ios_outlined, color: Colors.black),
              const SizedBox(width: 20),
              Text(
                'try_fix'.tr,
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
