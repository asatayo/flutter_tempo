import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:tempo/models/payment_model.dart';
import 'package:tempo/pages/payments/execution/cooperate_payments.dart';
import 'package:tempo/preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:tempo/preferences/shared_prefs_fun.dart';

class CooperatePage extends StatefulWidget {
  const CooperatePage({
    Key? key,
  }) : super(key: key);

  @override
  CooperatePageState createState() => CooperatePageState();
}

class CooperatePageState extends State<CooperatePage> {
   String? cooperateNumber;
  int _roomsCount = 2;
  final TextEditingController _cooperateController = TextEditingController();

  @override
  void initState() {
      _cooperateController.addListener(_inpuReferenceListener);
    super.initState();
  }

  @override
  void dispose() {
    _cooperateController.dispose();
    super.dispose();
  }

  void _inpuReferenceListener() {
    cooperateNumber = _cooperateController.text;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined,
                color: Theme.of(context).textTheme.bodyText2!.color),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('continue_with_payment'.tr,
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText2!.color)),
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                cooperateNumberOptions(context),
              ],
            ),
            Positioned(bottom: 10, child: _bookButton())
          ],
        ),
      ),
    ));
  }

  _checkTitle(String title) {
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
              style: const TextStyle(
                fontSize: 18,
              ),
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

  Widget cooperateNumberOptions(BuildContext context) {
    return Container(
        color: Theme.of(context).primaryColor,
        padding: const EdgeInsets.all(20),
        child: Card(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              _checkTitle('cooperate_number'),
              const SizedBox(
                height: 20,
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  controller: _cooperateController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'cooperate_number'.tr,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _checkTitle('number_of_rooms'),
              const SizedBox(height: 20),
              // Text('Horizontal', style: Theme.of(context).textTheme.headline6),
              NumberPicker(
                value: _roomsCount,
                minValue: 1,
                maxValue: 100,
                step: 1,
                itemHeight: 100,
                axis: Axis.horizontal,
                onChanged: (value) => setState(() => _roomsCount = value),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black26),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => setState(() {
                      final newValue = _roomsCount - 1;
                      _roomsCount = newValue.clamp(0, 100);
                    }),
                  ),
                  // Text('Current horizontal int value: $_roomsCount'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => setState(() {
                      final newValue = _roomsCount + 1;
                      _roomsCount = newValue.clamp(0, 100);
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 10)
            ],
          ),
        ));
  }

  Widget _bookButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
      child: InkWell(
        onTap: () async {
          if(cooperateNumber!=null && cooperateNumber!.isNotEmpty) {
            PaymentModel? paymentModel =
            await _storeDataToPref(cooperateNumber!, _roomsCount.toString());
            // ignore: unnecessary_null_comparison
            if (paymentModel != null) {
              // ignore: use_build_context_synchronously
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CooperatePaymentsPage(paymentModel: paymentModel)));
            } else {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Row(children: [
                  Text('invalid_cart'.tr),
                ]),
              ));
            }
          }else{
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Row(children: [
                Text('enter_cooperate_number'.tr),
              ]),
            ));
          }
        },
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('continue'.tr,
                  style: const TextStyle(color: Colors.black, fontSize: 16)),
              const SizedBox(width: 20),
              const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.black,
                size: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<PaymentModel> _storeDataToPref(
      String cooperateNumber, String roomsCount) async {
    await AppData().storeValue('COOPERATE_NUMBER', cooperateNumber);
    await AppData().storeValue('ROOMS_COUNT', roomsCount);
    PaymentModel paymentModel = await paymentDataToModel();
    return Future.value(paymentModel);
  }
}
