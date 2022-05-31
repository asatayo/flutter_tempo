import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:tempo/preferences/shared_preferences.dart';

class LogoutDialog extends StatefulWidget {
  const LogoutDialog({Key? key}) : super(key: key);
  @override
  LanguageAlertDialogState createState() => LanguageAlertDialogState();
}

class LanguageAlertDialogState extends State<LogoutDialog> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        insetPadding: const EdgeInsets.all(0),
        backgroundColor: Theme.of(context).cardColor,
        children: [
          Column(children: [
            Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('are_you_sure'.tr)],
                )),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            Container(
              // height: 60,
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ButtonTheme(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            width: 0, color: Colors.transparent),
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0)),
                      ),
                      child: Center(
                        child: Text('cancel'.tr,
                            style: const TextStyle(fontSize: 16)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  ButtonTheme(
                    child: OutlinedButton(
                      onPressed: () async {
                        Navigator.pop(context);
                         await AppData().removeData('isAuthenticated');
                          await AppData().removeData('authToken');
                          await AppData().removeData('profile');
                          await AppData().removeData('username');
                          await AppData().removeData('phone');
                          await AppData().removeData('first_name');
                          await AppData().removeData('last_name');

                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            width: 0, color: Colors.transparent),
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0)),
                      ),
                      child: Center(
                        child: Text('yes'.tr,
                            style: const TextStyle(
                                color: Colors.green, fontSize: 16)),
                      ),
                    ),
                  )
                ],
              ),
            )
          ])
        ]);
  }
}
