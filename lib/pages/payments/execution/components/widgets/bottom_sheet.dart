import 'package:flutter/material.dart';

simCardSelector(BuildContext context, String ussdCode) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.sim_card),
                title: const Text('sim_card_one'),
                onTap: () {
                  Navigator.pop(context);
                  // launchUssd(ussdCode, 1);
                },
              ),
              ListTile(
                leading: const Icon(Icons.sim_card),
                title: const Text('sim_card_two'),
                onTap: () {
                  Navigator.pop(context);
                  // launchUssd(ussdCode, 2);
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel),
                title: const Text('cancel'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }