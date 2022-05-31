import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:tempo/constants/constants.dart';
import 'package:tempo/http/auth.dart';
import 'package:tempo/http/api.dart';
import 'package:tempo/pages/signin/sign_in_page.dart';
import 'package:tempo/preferences/shared_preferences.dart';

class Password extends StatefulWidget {
  const Password({Key? key}) : super(key: key);
  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  late DateTime currentBackPressTime;
  bool visible = false;
  bool confirmvisible = false;
  bool newvisible = false;

  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _passwordConfirmController =
      TextEditingController();

  String? _currentPassword, _password, _confirmPassword;
  String _errorMessage = "";

  @override
  void initState() {
    _currentPasswordController.addListener(_currentPasswordInput);
    _passwordController.addListener(_passwordInput);
    _passwordConfirmController.addListener(_confirmPasswordInput);

    _password = "";
    _currentPassword = "";
    _confirmPassword = "";
    super.initState();
  }

  void _passwordInput() {
    setState(() {
      _errorMessage = "";
    });
    // _password = _currentPasswordConfirmController.text;
  }

  void _currentPasswordInput() {
    setState(() {
      _errorMessage = "";
    });
    // _currentPassword = _currentPasswordController.text;
  }

  void _confirmPasswordInput() {
    setState(() {
      _errorMessage = "";
    });
    // _confirmPassword = _passwordConfirmController.text;
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _currentPasswordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
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
          title: Text('change_password'.tr,
            style:
                TextStyle(color: Theme.of(context).textTheme.bodyText2!.color)),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - 119,
            child: Column(
              children: [
                profileType(),
                currentpasswordTextField(),
                const SizedBox(
                  height: 30,
                ),
                passwordTextField(),
                const SizedBox(
                  height: 30,
                ),
                confirmPasswordTextField(),
                passwordButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  profileType() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            child: Image.asset(
              'assets/logo.png',
              height: 50,
            ),
          ),
         const SizedBox(height: 20),
          Text(
            'change_password_desc'.tr,
            style: const TextStyle(
                    fontSize: 14,
                  )
          ),
        ],
      ),
    );
  }

  currentpasswordTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.lock,
                  color: Colors.grey,
                  size: 18,
                ),
                const SizedBox(width: 10,), 
                Expanded(
                  child: TextField(
                    controller: _currentPasswordController,
                    onChanged: (value) {
                      _currentPassword = value;
                    },
                    obscureText: !visible,
                    cursorColor: Colors.amber,
                    
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'current_password'.tr,
                      border: const UnderlineInputBorder(
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      visible = !visible;
                    });
                  },
                  child: Icon(
                    visible ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                    size: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  passwordTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.lock,
                  color: Colors.grey,
                  size: 18,
                ),
                const SizedBox(
                  width: 10,
                ), 
                Expanded(
                  child: TextField(
                    controller: _passwordController,
                    onChanged: (value) {
                      _password = value;
                    },
                    obscureText: !newvisible,
                    cursorColor: Colors.amber,
                    
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'new_password'.tr,
                      border: const UnderlineInputBorder(
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      newvisible = !newvisible;
                    });
                  },
                  child: Icon(
                    newvisible ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                    size: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  confirmPasswordTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.lock,
                  color: Colors.grey,
                  size: 18,
                ),
               const SizedBox(
                  width: 10,
                ), 
                Expanded(
                  child: TextField(
                    controller: _passwordConfirmController,
                    onChanged: (value) {
                      _confirmPassword = value;
                    },
                    obscureText: !confirmvisible,
                    cursorColor: Colors.amber,
                    
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'confirm_new_password'.tr,
                      border: const UnderlineInputBorder(
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      confirmvisible = !confirmvisible;
                    });
                  },
                  child: Icon(
                    confirmvisible ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                    size: 15,
                  ),
                ),
              ],
            ),
          ),
         const SizedBox(height: 10),
          inputMessage()
        ],
      ),
    );
  }

  inputMessage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(_errorMessage,
              textAlign: TextAlign.left,
              style: const TextStyle(color: Colors.red, fontSize: 12)),
        ],
      ),
    );
  }

  passwordButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 15,
      ),
      child: InkWell(
        onTap: () {
          if (isVerified()) {
            waitDialog();
          }
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.amber.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 2,
              ),
            ],
          ),
          child: Text(
            'Save_changes'.tr,
          ),
        ),
      ),
    );
  }

  divider() {
    return Expanded(
      child: Container(
        color: Colors.grey,
        height: 1,
        width: double.infinity,
      ),
    );
  }

  alertDialog(bool isSuccess) {
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
                    isSuccess
                        ? Image.asset(
                            'assets/done.png',
                            color: Colors.amber,
                            height: 50,
                            width: 50,
                          )
                        // ignore: deprecated_member_use
                        : const FaIcon(FontAwesomeIcons.sadTear),
                   const SizedBox(height: 30,),
                    Text(
                      httpResponseMessage,
                      textAlign: TextAlign.center,
                    ),
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    InkWell(
                      onTap: () async {
                        if (isSuccess) {
                          Navigator.pop(context);

                          Timer.periodic(
                            const Duration(seconds: 1),
                            (timer) async {
                              await AppData().removeData('isAuthenticated');
                              await AppData().removeData('isProvider');
                              await AppData().removeData('phone');
                              await AppData().removeData('authToken');
                              await AppData().removeData('username');
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) => const Signin(
                                          shouldAutheticate: false)));
                            },
                          );
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(fixPadding * 1.5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          border: Border.all(color: Colors.amber),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.amber.withOpacity(0.2),
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
                    'Updating Wait...',
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
    var data = {
      'new_password': _password,
      'current_password': _currentPassword,
      'confirm_password': _confirmPassword
    };
    
    if (await changeMyPassword(data)) {
      Navigator.pop(context);

      Timer.periodic(
        const Duration(seconds: 1),
        (timer) async {
          await AppData().removeData('isAuthenticated');
          await AppData().removeData('isProvider');
          await AppData().removeData('phone');
          await AppData().removeData('authToken');
          await AppData().removeData('username');
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const Signin(
                      shouldAutheticate: false)));
        },
      );
    } else {
      Navigator.pop(context);
      alertDialog(false);
    }
  }

  bool isVerified() {
    bool isOK = false;
    if (_password!.isNotEmpty &&
        _currentPassword!.isNotEmpty &&
        _confirmPassword!.isNotEmpty) {
      if (_password!.length >= 6) {
        if (_password == _confirmPassword) {
          isOK = true;
        } else {
          setState(() {
            _errorMessage = "The new passwords mismatch";
          });
        }
      } else {
        setState(() {
          _errorMessage = "Password is too short";
        });
      }
    } else {
      if (_currentPassword!.isEmpty &&
          _password!.isEmpty &&
          _confirmPassword!.isEmpty) {
        setState(() {
          _errorMessage = "All fields are required!";
        });
      } else {
        if (_currentPassword!.isEmpty && _password!.isEmpty) {
          setState(() {
            _errorMessage = "Current password and new password are required!";
          });
        }
        if (_currentPassword!.isEmpty && _confirmPassword!.isEmpty) {
          setState(() {
            _errorMessage =
                "Current password and confirm password are required!";
          });
        }

        if (_password!.isEmpty && _confirmPassword!.isEmpty) {
          setState(() {
            _errorMessage = "New password and confirm password are required!";
          });
        }

        if (_currentPassword!.isEmpty ||
            _password!.isEmpty ||
            _confirmPassword!.isEmpty) {
          setState(() {
            _errorMessage = "All fields are required!";
          });
        }
      }
    }
    return isOK;
  }
}
