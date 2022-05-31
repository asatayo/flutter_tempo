import 'package:flutter/material.dart';
import '../preferences/shared_preferences.dart';

class RegionAdapter extends StatelessWidget {
  final String name;
  const RegionAdapter({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
          child: Container(
        padding:
            const EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(30)),
              ),
              child: Center(
                  child: Text(
                name[0].toUpperCase(),
                style: const TextStyle(fontSize: 16),
              )),
            ),
            const SizedBox(width: 20),
            Text(name)
          ],
        ),
      )),
      onTap: () async {
          _storeChanges();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(name),
          duration: const Duration(seconds: 2),
        ));
        Navigator.pop(context);
      },
    );
  }

  Future<void> _storeChanges() async {
    await AppData().storeValue('REGION', name);
  }
}
