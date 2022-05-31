

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:tempo/constants/constants.dart';
import 'package:tempo/constants/form.dart';
import 'package:tempo/http/api.dart';
import 'package:tempo/http/auth.dart';
import 'package:tempo/pages/dashboard/dashboard_page.dart';
import 'package:tempo/pages/signup/sign_up.dart';
import 'package:tempo/preferences/shared_preferences.dart';

class Signin extends StatefulWidget {
  final bool shouldAutheticate;
  const Signin(
      {Key? key, required this.shouldAutheticate})
      : super(key: key);
  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  late DateTime currentBackPressTime;
  bool visible = false;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _phone, _password,  _errorMessage;

  @override
  void initState() {
    _phoneController.addListener(_phoneInput);
    _passwordController.addListener(_passwordInput);
    _phone = "";
    _password = "";
    _errorMessage = "Phone and password are required!";

    super.initState();
  }

  void _phoneInput() {
    _phone = _phoneController.text;
  }

  void _passwordInput() {
    _password = _passwordController.text;
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _backButton() async {
    await AppData().removeData('isAuthenticated');
    await AppData().removeData('isManager');
    await AppData().removeData('phone');
    await AppData().removeData('authToken');
    await AppData().removeData('username');
    await AppData().removeData('first_name');
    await AppData().removeData('last_name');

    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Signin(shouldAutheticate: false)),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _backButton();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined,
                color: Theme.of(context).textTheme.bodyText2!.color),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('sign_in_now'.tr,
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText2!.color)),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    profileType(),
                    phoneTextField(),
                    const SizedBox(
                      height: 20,
                    ),
                    passwordTextField(),
                    const SizedBox(
                      height: 20,
                    ),
                    signinButton(),
                    const SizedBox(
                      height: 20,
                    ),
                    otherOptions(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Press Back Once Again to Exit.',
        backgroundColor: blackColor,
        textColor: whiteColor,
      );
      return false;
    } else {
      return true;
    }
  }

  profileType() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: fixPadding * 2.0,
        vertical: fixPadding * 2.0,
      ),
      child: Column(
        children: [
          Image.asset(
             'assets/images/logo.png',
            height: 50,
          ),
          heightSpace,
          Text(widget.shouldAutheticate
                    ? 'Login to continue'
                    : 'Login',
          ),
        ],
      ),
    );
  }

  phoneTextField() {
    return Container(
        height: 55,
        decoration:  BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: const [
            BoxShadow(
              color: Colors.amber,
              spreadRadius: 2,
              blurRadius: 2,
            ),
          ],
        ),
        child: TextFormField(
          controller: _phoneController,
          onSaved: (newValue) => _phone = newValue,
          onChanged: (value) {
            _phone = value;
          },
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: null,
            errorText: null,
            contentPadding: newFormInputPadding,
            errorStyle: TextStyle(height: 0),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Phone number",
            focusedBorder: InputBorder.none,
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ));
  }

  passwordTextField() {
    return Container(
        height: 55,
        decoration:  BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: const [
            BoxShadow(
              color: Colors.amber,
              spreadRadius: 2,
              blurRadius: 2,
            ),
          ],
        ),
        child: TextFormField(
          controller: _passwordController,
          obscureText: !visible,
          onSaved: (newValue) => _password = newValue,
          onChanged: (value) {
            _password = value;
          },
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            labelText: null,
            errorText: null,
            contentPadding: newFormInputPadding,
            errorStyle: TextStyle(height: 0),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Account's password",
            focusedBorder: InputBorder.none,
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ));
  }



  signinButton() {
    return InkWell(
      onTap: () {
        if (isVerified()) {
          waitDialog();
        }

        // if (isSuccessfull(userna)) {}
        // Navigator.push(context,MaterialPageRoute(builder: (context) => const Signup()));
      },
      child: Container(
        height: 55,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.red,
              spreadRadius: 2,
              blurRadius: 2,
            ),
          ],
        ),
        child: Text(
          'Sign In',
          style: white18SemiBoldTextStyle,
        ),
      ),
    );
  }

  otherOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Column(
        children: [
          heightSpace,
          heightSpace,
          heightSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Don\'t have account? ',
                style: white14BoldTextStyle,
              ),
              InkWell(
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Signup(
                            shouldAuthenticate: widget.shouldAutheticate,
                          )),
                ),
                child: Text(
                  'Sign up now',
                  style: blue14BoldTextStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  divider() {
    return Expanded(
      child: Container(
        color: greyColor,
        height: 1,
        width: double.infinity,
      ),
    );
  }

  cornerImage() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Image.asset(
        'assets/bg.png',
        height: 125.0,
        fit: BoxFit.cover,
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
              const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
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
                  const SizedBox(
                    height: 80,
                    width: 80,
                    child: CircularProgressIndicator(),
                  ),
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  Text(
                    'Authenticating Wait...',
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
    var data = {'phone': _phone, 'password': _password};
    if (await loginAuthentication(data)) {
      await AppData().removeData('shouldAuthenticate');

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
     
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardPage()),
        );
      
    } else {
      Navigator.pop(context);
      _errorMessage = httpResponseMessage;
      // print(httpResponseMessage);
      bottomDialog(context);
    }
  }

  bool isVerified() {
    bool isOK = false;
    if (_phone!.isNotEmpty && _password!.isNotEmpty) {
      if (_phone!.length >= 10) {
        isOK = true;
      } else {
        setState(() {
          _errorMessage = "Invalid phone number";
          bottomDialog(context);
        });
      }
    } else {
      if (_phone!.isEmpty && _password!.isEmpty) {
        setState(() {
          _errorMessage = "Phone and password are required!";
          bottomDialog(context);
        });
      } else {
        if (_phone!.isEmpty) {
          setState(() {
            _errorMessage = "Phone is required!";
            bottomDialog(context);
          });
        } else {
          setState(() {
            _errorMessage = "Password is required!";
            bottomDialog(context);
          });
        }
      }
    }
    return isOK;
  }

  bottomDialog(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: whiteColor,
          child: Wrap(
            children: <Widget>[
              Center(
                  child: Container(
                padding: const EdgeInsets.all(fixPadding * 2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    heightSpace,
                    heightSpace,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const <Widget>[
                        Icon(
                          Icons.warning,
                          color: primaryColor,
                          size: 50.0,
                        ),
                        widthSpace,
                        widthSpace,
                      ],
                    ),
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    Text(
                      _errorMessage!,
                      textAlign: TextAlign.center,
                      style: black15SemiBoldTextStyle,
                    ),
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    InkWell(
                        onTap: () async {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(fixPadding * 1.2),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.amber.withOpacity(0.4),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            child: Text(
                              'ok'.tr,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        )),
                  ],
                ),
              ))
            ],
          ),
        );
      },
    );
  }
}
