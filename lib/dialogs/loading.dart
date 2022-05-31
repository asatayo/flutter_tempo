import 'package:tempo/constants/constants.dart';
import 'package:flutter/material.dart';

 class   AppDialog  {
  static loadingDialog(BuildContext context, String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (contxet) {
        return Dialog(
          insetPadding:
              const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  heightSpace,
                 Image.asset(
                    'assets/images/gif.gif',
                    height: 60,
                  ),
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  Text(
                   message, 
                    style: grey15MediumTextStyle,
                  ),
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  heightSpace,
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
