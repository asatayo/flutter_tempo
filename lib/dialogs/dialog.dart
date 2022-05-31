
import 'package:flutter/material.dart';
import 'package:tempo/constants/constants.dart';

class AppDialogView {
  final String title;
  AppDialogView({required this.title});
  loadingDialogView(context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (contxet) {
        return Dialog(
                backgroundColor: Colors.white,
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 10.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    const SizedBox(height: 10,),
                  Image.asset('assets/images/gif.gif', height: 60,),
                    const SizedBox(height: 0,),
                  Text(
                   title,
                    style: grey15MediumTextStyle,
                  ),
                 const SizedBox(height: 30,)
                ],
              ),
            ],
          ),
        );
      },
    );
  }

   paymentDialog(context, Function() onTap) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (contxet) {
        return Dialog(
          backgroundColor: Colors.white,
          insetPadding:
              const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    'assets/images/gif.gif',
                    height: 60,
                  ),
                  Text(
                    "Waiting confirmation..",
                    style: grey15MediumTextStyle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    title,
                    style: grey15MediumTextStyle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 10, bottom: 30, right: 10),
                      child: InkWell(
                          onTap: onTap,
                          child: Container(
                            height: 35,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.6),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                ),
                              ],
                            ),
                            child: Text(
                              "Cancel Payments",
                              style: white14SemiBoldTextStyle,
                            ),
                          ))),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  alertDialogVIew(BuildContext context,String asset, Function clickAction) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding:
              const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: fixPadding * 2.0,
                  vertical: fixPadding * 3.0,
                ),
                child: Column(
                  children: [
                    Image.asset(
                            asset,
                            color: primaryColor,
                            height: 50,
                            width: 50,
                          ),
                
                    const SizedBox(height: 20,),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: black15SemiBoldTextStyle,
                    ),
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    InkWell(
                      onTap: () async {
                        clickAction();  
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(fixPadding * 1.5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          // border: Border.all(color: primaryColor),
                          borderRadius: BorderRadius.circular(10),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: primaryColor.withOpacity(0.2),
                          //     spreadRadius: 2,
                          //     blurRadius: 2,
                          //   ),
                          // ],
                        ),
                        child: Text(
                          'OK',
                          style: white18SemiBoldTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
