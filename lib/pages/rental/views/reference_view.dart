 import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:tempo/models/rental_model.dart';
import 'package:tempo/pages/payments/checkout.dart';
import 'package:tempo/pages/rental/views/house_details.dart';
import 'package:tempo/widgets/satefull/text.dart';

refrenceView(BuildContext context, RentalModel rentalModel) {
    return Card(
      elevation: 5,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(children: [
            titleText('house_details'.tr, context),
            const SizedBox(height: 10),
            confirmButton(context),
            const SizedBox(height: 10),
            Card(
              color: Colors.amber,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Text(
                      '${'street'.tr} : ${'no_data'.tr}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    )),
                  ],
                ),
              ),
            ),
            Card(
              color: Colors.amber,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Text(
                      '${'contact_phone'.tr} : ${'no_data'.tr}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    )),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 1),
            Card(
              color: Colors.amber,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Text(
                      '${'category'.tr} : ${'no_data'.tr}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    )),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 1),
            Card(
              color: Colors.amber,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Text(
                      '${'map'.tr} : ${'no_map'.tr}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    )),
                    IconButton(
                        icon: const Icon(Icons.location_off_outlined,
                            color: Colors.grey),
                        onPressed: (){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("you_are_opening".tr),
                            ));
                        }),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            houseDetails(context, rentalModel)
          ])),
    );
  }


  confirmButton(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(left: 20, top: 10, bottom: 20, right: 20),
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Payment(isRental: true)));
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
                  Text('pay_now'.tr,
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


