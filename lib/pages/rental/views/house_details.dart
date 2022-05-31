import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:tempo/models/rental_model.dart';

houseDetails(BuildContext context, RentalModel rentalModel) {
  double width = MediaQuery.of(context).size.width;
  return Center(
    child: Table(
      defaultColumnWidth: FixedColumnWidth((width / 2) - 5),
      border: TableBorder.all(
          color: Theme.of(context).primaryColor,
          style: BorderStyle.solid,
          width: 1),
      children: [
        TableRow(children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text('ideneity'.tr)),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(rentalModel.identity)),
        ]),
        TableRow(children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text('water'.tr)),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(rentalModel.water
                  ? 'available'.tr
                  : 'not_availble'.tr)),
        ]),
        TableRow(children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text('electricity'.tr)),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(rentalModel.electricity
                  ? 'available'.tr
                  : 'not_availble'.tr)),
        ]),
        TableRow(children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text('transport'.tr)),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(rentalModel.transport.contains('Public')
                  ? 'public_transport'.tr
                  : 'private_transport'.tr)),
        ]),
        TableRow(children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text('price_per_month'.tr)),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(rentalModel.hasRoom
                  ? 'rented_as_rooms'.tr
                  : '${rentalModel.price}.00TZS')),
        ]),
        TableRow(children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text('min_booking_months'.tr)),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(rentalModel.months + 'months'.tr)),
        ]),
      ],
    ),
  );
}
