import 'package:flutter/material.dart';
import 'package:tempo/pages/payments/execution/components/widgets/cance_button.dart';

import 'intructions.dart';
import 'package:get/get.dart';

Widget loadingStatus(BuildContext context, cancelCallBackFun) {
  return Container(
    color: Theme.of(context).primaryColor,
    padding: const EdgeInsets.all(5),
    child: Card(
        child: Column(
      children: [
        checkTitle('waiting_for_payment', context),
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const CircularProgressIndicator(),
              const SizedBox(
                height: 20,
              ),
              Text(
                'waiting'.tr,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 30,
              ),
              cancelButton(context, cancelCallBackFun),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        )
      ],
    )),
  );


}
