
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';
import 'package:tempo/constants/constants.dart';
import 'package:tempo/http/auth.dart';
import 'package:tempo/http/api.dart';
import 'package:tempo/pages/dashboard/dashboard_page.dart';
import 'package:tempo/pages/signup/sign_up.dart';
import 'package:tempo/preferences/shared_preferences.dart';

class Otp extends StatefulWidget {
  final bool shouldAuthenticate;
  final String phone;
  const Otp({Key? key, required this.shouldAuthenticate, required this.phone}) : super(key: key);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final int _otpCodeLength = 6;
  String _otpCode = "";
  final intRegex = RegExp(r'\d+', multiLine: true);
  TextEditingController textEditingController = TextEditingController(text: "");

  String otp = "";
  String message = "";

  @override
  void initState() {
    super.initState();
    _startListeningSms();
    textEditingController = TextEditingController();
    _getSignatureCode();
  }

  @override
  void dispose() {
    super.dispose();
    SmsVerification.stopListening();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            'otp_verification'.tr,
          ),
        ),
        body: SafeArea(
          child: Center(
            child: ListView(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              children: [
                SizedBox(
                  child: Column(
                    children: [
                      Text('verify_your_phone'.tr,),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        'we_have_sent'.tr+widget.phone,
                        textAlign: TextAlign.center,
                      ),
                     const  SizedBox(height: 50,),
                      Text(
                        'enter_otp_here'.tr,
                      ),
                      const SizedBox(height: 20),
                      codeTextField(),
                      startButton(),
                      const SizedBox(
                        height: 60,
                      ),
                      _resendOTP(),
                      const SizedBox(
                        height: 20,
                      ),
                      _cancelOTP(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  _onOtpCallBack(String otpCodePass, bool isAutofill) {
    setState(() {
      // _otpCode = otpCode;
      if (otpCodePass.length == _otpCodeLength && isAutofill) {
        waitDialog();
      } else if (otpCodePass.length == _otpCodeLength && !isAutofill) {
        waitDialog();
      } else {}
    });
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Theme.of(context).primaryColor),
      borderRadius: BorderRadius.circular(5.0),
    );
  }

  /// get signature code
  _getSignatureCode() async {
    // String signature = await SmsVerification.getAppSignature();
    // print("signature $signature");
  }

  /// listen sms
  _startListeningSms() {
    SmsVerification.startListeningSms().then((message) {
      setState(() {
        _otpCode = SmsVerification.getCode(message, intRegex);
        textEditingController.text = _otpCode;
        _onOtpCallBack(_otpCode, true);
      });
    });
  }

  codeTextField() {
    return TextFieldPin(
        textController: textEditingController,
        autoFocus: true,
        codeLength: _otpCodeLength,
        alignment: MainAxisAlignment.center,
        defaultBoxSize: 40.0,
        margin: 5,
        selectedBoxSize: 40.0,
        textStyle: const TextStyle(fontSize: 16),
        defaultDecoration: _pinPutDecoration.copyWith(
            border: Border.all(
                color: Colors.amber)),
        selectedDecoration: _pinPutDecoration,
        onChange: (code) {
          _onOtpCallBack(code, false);
        });
  }

  startButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 15,
      ),
      child: InkWell(
        onTap: () => waitDialog(),
        child: Container(
          height: 60,
          width: double.infinity,
          padding: const EdgeInsets.all(5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: primaryColor.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 2,
              ),
            ],
          ),
          child: Text(
            'get_started'.tr,
            style: white18SemiBoldTextStyle,
          ),
        ),
      ),
    );
  }

  _cancelOTP() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
              onPressed: () async {
                await AppData().storeValue('isWaiting', false);
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Signup(shouldAuthenticate: widget.shouldAuthenticate)));
              },
              icon: const Icon(
                Icons.clear,
                color: Colors.red,
                size: 50,
              ))
        ]));
  }

  _resendOTP() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          heightSpace,
          Text(message),
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'havent_seen_yet'.tr,
              ),
              const SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: () async {
                  setState(() {
                    message = "Sending...";
                  });
                  var data = {
                    'language': 'en',
                    'phone': widget.phone,
                  };
                  if (await resendOTP(data)) {
                    setState(() {
                      message = httpResponseMessage;
                    });
                  }
                },
                child: Text(
                  'resend_code'.tr,
                  style: blue14BoldTextStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  waitDialog() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (contxet) {
        return Dialog(
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
                
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  Text(
                    'Verifying...',
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
    otp = textEditingController.text;
    var data = {
      'language': 'en',
      'otp': otp,
      'phone': widget.phone,
    };

    if (await isValidOTP(data)) {
      await AppData().storeValue('isWaiting', false);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const DashboardPage()),
      );
    } else {
      Navigator.pop(context);
      invalidDialog();
    }
  }

  invalidDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 15,
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/done.png',
                      color: primaryColor,
                      height: 50,
                      width: 50,
                    ),
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    Text(
                      // ignore: prefer_if_null_operators
                      httpResponseMessage,
                      textAlign: TextAlign.center,
                      style: grey13RegularTextStyle,
                    ),
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          border: Border.all(color: primaryColor),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 2,
                            ),
                          ],
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
