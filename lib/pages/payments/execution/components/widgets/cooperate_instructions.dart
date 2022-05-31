import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget checkInstructions(BuildContext context, bool hasReceiptResponse, String receiptResponseMessage, bool hasReference,
    paymentRefNumber, bool isCopied, copyCallBackFun,tryCallBackFun, String operator) {
  return FutureBuilder(builder: (context, snapshot) {
    if (snapshot.hasData) {
      if(snapshot.data!=null){
          return Container(
    color: Theme.of(context).primaryColor,
    padding: const EdgeInsets.all(5),
    child: Card(
        child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(children: [
              checkTitle('payment_reference_number', context),
              const SizedBox(height: 10),
              hasReference
                  ? Card(
                      color: paymentRefNumber.length != 21
                          ? Colors.red
                          : Colors.amber,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: Text(
                              paymentRefNumber,
                              style: TextStyle(
                                  fontSize:
                                      paymentRefNumber.length == 21 ? 18 : 15,
                                  color: paymentRefNumber.length == 21? Colors.black: Colors.white),
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            )),
                            paymentRefNumber.length != 21
                                ? const SizedBox(
                                    height: 0,
                                  )
                                : IconButton(
                                    icon: isCopied
                                        ? const Icon(Icons.copy,
                                            color: Colors.green)
                                        : const Icon(Icons.copy_all,
                                            color: Colors.black),
                                    onPressed: copyCallBackFun),
                          ],
                        ),
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
                hasReceiptResponse? Card(
                      color:  Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                        child: Text(
                                      receiptResponseMessage,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.white),
                                      softWrap: true,
                                      overflow: TextOverflow.fade,
                                    )),
                                        IconButton(
                                            icon: const Icon(Icons.refresh,
                                                    color: Colors.white),
                                            onPressed: tryCallBackFun),
                                  ],
                                ),
                      ),
                    ): const SizedBox(height: 0,),
              const SizedBox(height: 10),
              const Divider(
                height: 1,
              ),
              const SizedBox(height: 5),
              paymentRefNumber.length == 21
                  ? _paymentDescription(operator)
                  : _invalidPayments(),
              const SizedBox(height: 20),
            ]))),
  );
      }else{
        return SizedBox(height: 200, child:Center(child:Text('failed_to_load_reference_number'.tr)));
      }
    } else {
      return const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()));
    }
  }, 
  future: checkNumber(paymentRefNumber),
);
}

Future<String> checkNumber(String reference){
return Future.value(reference);
}

checkTitle(String title, context) {
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

Widget _invalidPayments() {
  return Text(
    'invalid_reference_number'.tr,
    style: const TextStyle(fontSize: 16, height: 1.5),
  );
}

_paymentDescription(String option) {
  
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
            'check_guide'.tr,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
       
      );
}
