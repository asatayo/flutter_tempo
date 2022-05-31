import 'package:permission_handler/permission_handler.dart';

Future<bool> isAccessGranted(Permission permission) async {
  bool granted = false;
  if (await permission.isGranted) {
    granted = true;
  } else {
    await permission.request();
    if (await permission.isGranted) {
      granted = true;
    } else {
      granted = false;
    }
  }

  return Future.value(granted);
}
