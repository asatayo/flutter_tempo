import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:tempo/constants/constants.dart';
import 'package:tempo/constants/form.dart';
import 'package:tempo/http/auth.dart';
import 'package:tempo/http/api.dart';
import 'package:tempo/pages/signin/sign_in_page.dart';
import 'package:tempo/pages/signup/otp.dart';
import 'package:tempo/preferences/shared_preferences.dart';

class Signup extends StatefulWidget {
  final bool shouldAuthenticate;
  const Signup({Key? key, required this.shouldAuthenticate}) : super(key: key);
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late DateTime currentBackPressTime;
  bool visible = false;
  bool isConfirmVisible = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  late String _username, _phone, _password, _confirmPassword,_errorMessage = "";

  @override
  void initState() {
    _usernameController.addListener(_usernameInput);
    _confirmPasswordController.addListener(_confirmPasswordInput);
    _phoneController.addListener(_phoneInput);
    _passwordController.addListener(_passwordInput);
    _phone = "";
    _password = "";
    _username = "";
    _confirmPassword = "";
    super.initState();
  }

  void _usernameInput() {
    setState(() {
      _errorMessage = "";
    });
    _username = _usernameController.text;
  }

  void _phoneInput() {
    setState(() {
      _errorMessage = "";
    });
    _phone = _phoneController.text;
  }

  void _passwordInput() {
    setState(() {
      _errorMessage = "";
    });
    _password = _passwordController.text;
  }

  void _confirmPasswordInput() {
    setState(() {
      _errorMessage = "";
    });
    _confirmPassword = _confirmPasswordController.text;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _phoneController.dispose();
    _confirmPasswordController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          bool backStatus = onWillPop();
          if (backStatus) {
            exit(0);
          }
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
            title: Text('sign_up_free'.tr,
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText2!.color)),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: Center(
            child: ListView(
              physics: const ScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      profileType(),
                      nameTextField(),
                      const SizedBox(height: 20.0),
                      phoneTextField(),
                      const SizedBox(height: 20.0),
                      passwordTextField(),
                      const SizedBox(height: 20.0),
                      confirmPasswordTextField(),
                      const SizedBox(height: 40.0),
                      signinButton(),
                      const SizedBox(height: 10.0),
                      otherOptions(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Press Back Once Again to Exit.',
        backgroundColor: Colors.deepOrange,
        textColor:  Colors.white
      );
      return false;
    } else {
      return true;
    }
  }

  profileType() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 50.0,
      ),
      child: Column(
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: 50,
          ),
          const SizedBox(height: 20),
          Text(
            'create_account'.tr,
          ),
        ],
      ),
    );
  }

  nameTextField() {
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
          controller: _usernameController,
          onSaved: (newValue) => _username = newValue!,
          onChanged: (value) {
            _username = value;
          },
          keyboardType: TextInputType.name,
          decoration: const InputDecoration(
            labelText: null,
            errorText: null,
            contentPadding: newFormInputPadding,
            errorStyle: TextStyle(height: 0),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Account's username e.g mysherehe",
            focusedBorder: InputBorder.none,
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ));
  }

  phoneTextField() {
    return Container(
        height: 55,
        decoration:  BoxDecoration(
          color:  Theme.of(context).primaryColor,
          borderRadius: const  BorderRadius.all(Radius.circular(10)),
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
          onSaved: (newValue) => _phone = newValue!,
          onChanged: (value) {
            _phone = value;
          },
          keyboardType: TextInputType.phone,
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
          color:  Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: const [
            BoxShadow(
              color: Colors.amber,
              spreadRadius: 2,
              blurRadius: 2,
            ),
          ],
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(children: [
              Expanded(
                  child: TextFormField(
                controller: _passwordController,
                obscureText: !visible,
                onSaved: (newValue) => _password = newValue!,
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
              )),
              InkWell(
                onTap: () {
                  setState(() {
                    visible = !visible;
                  });
                },
                child: Icon(
                  visible ? Icons.visibility : Icons.visibility_off,
                  color: greyColor,
                  size: 15,
                ),
              ),
            ])));
  }

  confirmPasswordTextField() {
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
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(children: [
              Expanded(
                  child: TextFormField(
                controller: _confirmPasswordController,
                obscureText: !isConfirmVisible,
                onSaved: (newValue) => _confirmPassword = newValue!,
                onChanged: (value) {
                  _confirmPassword = value;
                },
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: null,
                  errorText: null,
                  contentPadding: newFormInputPadding,
                  errorStyle: TextStyle(height: 0),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: "Confirm account's password",
                  focusedBorder: InputBorder.none,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              )),
              InkWell(
                onTap: () {
                  setState(() {
                    visible = !isConfirmVisible;
                  });
                },
                child: Icon(
                  visible ? Icons.visibility : Icons.visibility_off,
                  color: greyColor,
                  size: 15,
                ),
              ),
            ])));
  }

  signinButton() {
    return InkWell(
      onTap: () async {
        //  await AppData().storeValue('phone', _phone);

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
          boxShadow: [
            BoxShadow(
              color:  Theme.of(context).primaryColor.withOpacity(0.6),
              spreadRadius: 2,
              blurRadius: 2,
            ),
          ],
        ),
        child: Text(
          'sign_up'.tr,
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
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'have_an_account'.tr,
              ),
              InkWell(
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Signin(
                            shouldAutheticate: false,
                          )),
                ),
                child: Text(
                  'Sign in now',
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
          backgroundColor: Colors.transparent, 
          insetPadding:
              const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                    SizedBox(height: 20),
                   SizedBox(width: 50, height: 50, child: CircularProgressIndicator()),
                   SizedBox(height: 20),
                  Text(
                    'Authenticating Wait...',
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ],
          ),
        );
      },
    );

    var data = {
      'username': _username,
      'language': 'en',
      'phone': _phone,
      "password": _password,
    };

    if (await signUpAuthentication(data)) {
      
      Navigator.pop(context);
      await AppData().storeValue('isWaiting', true);
      await AppData().storeValue('username', _username);
      await AppData().storeValue('phone', _phone);

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Otp(
                  shouldAuthenticate: widget.shouldAuthenticate,
                  phone: _phone,
                )),
      );
    } else {
      Navigator.pop(context);
      _errorMessage = httpResponseMessage;
      bottomDialog(context);
    }
  }

  bool isVerified() {
    bool isOK = false;
    if (_username.isNotEmpty &&
        _phone.isNotEmpty &&
        _password.isNotEmpty &&
        _confirmPassword.isNotEmpty) {
      if (_phone.length >= 10) {
        if (_password != _confirmPassword) {
          setState(() {
            _errorMessage = "password_mismatches".tr;

            bottomDialog(context);
          });
        } else {
          isOK = true;
        }
      } else {
        setState(() {
          _errorMessage = "invalid_phone".tr;
          bottomDialog(context);
        });
      }
    } else {
      setState(() {
        _errorMessage = "fill_all".tr;
        bottomDialog(context);
      });
    }
    return isOK;
  }

  bottomDialog(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color:  Theme.of(context).primaryColor,
          child: Wrap(
            children: <Widget>[
              Center(
                  child: Container(
                padding: const EdgeInsets.all(fixPadding * 2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 30),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const <Widget>[
                        Icon(
                          Icons.warning,
                          color: Colors.amber,
                          size: 50.0,
                        ),
                        widthSpace,
                        widthSpace,
                      ],
                    ),
                    const SizedBox(height: 30),
                    Text(
                      _errorMessage,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
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
                              color:  Theme.of(context).primaryColor,
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




// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get_utils/src/extensions/internacionalization.dart';
// import 'package:tempo/http/aauth.dart';
// import 'package:tempo/http/api.dart';
// import 'package:tempo/pages/signin/sign_in_page.dart';
// import 'package:tempo/pages/validations/validations.dart';
// import 'package:tempo/utils/prefs.dart';
// import 'package:tempo/widgets/satefull/loading.dart';
// import 'package:tempo/widgets/satefull/message_dialog.dart';

//  bool isRegistredSucessfully = false;

// class SignUpPage extends StatefulWidget {
//    const SignUpPage({Key key}) : super(key: key);
//   @override
//   _SignUpPage createState() => _SignUpPage();
// }

// class _SignUpPage extends State<SignUpPage> {
//   String _phone = '';
//   String _password = '';
//   String message = 'registering'.tr;
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   String themeMode = 'dark';
//   bool _phoneValid = false;
//   bool _hidePassword = true;
//   Icon _passwordIcon =  const Icon(FontAwesomeIcons.eye);
//    Color _passwordIconColor;
//    String _phoneMessage = "";
//    String _passwordMessage = "";
//   Icon _phoneIcon =  const Icon(FontAwesomeIcons.info);
//    Color _phoneIconColor;
//   bool _passwordValid = false;
//   int trialCount = 0;
//    dynamic httpResponse;
//   @override
//   initState() {
//     _phoneController.addListener(_phoneDetails);
//     _passwordController.addListener(_passwordDetails);
//     super.initState();
//   }

//   @override
//   dispose() {
//     _phoneController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   _phoneDetails() {
//     _phone = _phoneController.text;
//     setState(() {
//       _phoneMessage = " ";
//       if (ValidateInputs.isValid(_phone, 'phone')) {
//         _phoneIcon =  const Icon(FontAwesomeIcons.check);
//         _phoneIconColor = Colors.green;
//         _phoneValid = true;
//       } else {
//         _phoneIcon =  const Icon(FontAwesomeIcons.times);
//         _phoneIconColor = Colors.red;
//         _phoneValid = false;
//       }
//     });
//   }

//   _passwordDetails() {
//     _password = _passwordController.text;
//     _passwordMessage = " ";
//     setState(() {
//       if (ValidateInputs.isValid(_password, 'password')) {
//         _passwordIconColor = Colors.green;
//         _passwordValid = true;
//       } else {
//         _passwordIconColor = Colors.red;
//         _passwordValid = false;
//       }
//     });
//   }

//   _signUp() {
//     if (_passwordValid && _phoneValid) {
//       showLoadingWithMessage(context, 'please_wait'.tr);
//       _authenticateUser();
//     } else {
//       setState(() {
//         if (!_phoneValid) {
//           if (_phone.isEmpty) {
//             _phoneMessage = 'phone_'.tr;
//           } else {
//             _phoneMessage = 'invalid_phone'.tr;
//           }
//         }
//         if (!_passwordValid) {
//           if (_password.isEmpty) {
//             _passwordMessage = 'password_'.tr;
//           } else {
//             _passwordMessage = 'too_short'.tr;
//           }
//         }
//       });
//     }
//   }

//   _authenticateUser() async {
//     String _locale = await Prefs.getLocale();
//     var data = {
//       'phone': _phone,
//       'password': _password,
//       'language': _locale,
//     };
//       if(await isSignedUpSuccessfull(data)){
//            Navigator.pop(context);
          
//       }
//   }

//   _togglePassword() {
//     setState(() {
//       if (_hidePassword) {
//         _passwordIcon =  const Icon(FontAwesomeIcons.eyeSlash);
//         _hidePassword = false;
//       } else {
//         _passwordIcon =  const Icon(FontAwesomeIcons.eye);
//         _hidePassword = true;
//       }
//     });
//   }

//   _phoneInfo() {
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     // print(isEnglish);
//     _passwordIconColor = Theme.of(context).iconTheme.color;
//     _phoneIconColor = Theme.of(context).iconTheme.color;

//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           elevation: 2,
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back_ios_new,
//                 color: Theme.of(context).iconTheme.color),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//           title: Text('create_account'.tr,
//               style: TextStyle(color: Theme.of(context).iconTheme.color)),
//           backgroundColor: Theme.of(context).primaryColor,
//         ),
//         body: Center(
//             child: SingleChildScrollView(
//                 child: Container(
//                     padding:  const EdgeInsets.symmetric(horizontal: 20),
//                     child: Column(
//                       children: [
//                         _profileUserField(),
//                          const SizedBox(height: 15),
//                         _phoneField(),
//                          const SizedBox(height: 15),
//                         _passwordField(),
//                          const SizedBox(height: 15),
//                         _signupButton(),
//                          const SizedBox(height: 0),
//                         _deparatorField(),
//                         _signInButton(),
//                       ],
//                     )))),
//       ),
//     );
//   }

//   Widget _profileUserField() {
//     return Center(
//         child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//           Container(
//             height: 85,
//             width: 85,
//             decoration: BoxDecoration(
//                 color: Theme.of(context).primaryColor,
//                 borderRadius:  const BorderRadius.all(Radius.circular(100)),
//                 boxShadow: const [
//                   BoxShadow(
//                     blurRadius: 4,
//                     offset:  Offset(4, 5), // Shadow
//                     color: Colors.amber,
//                   )
//                 ]),
//             child: ClipRRect(
//               borderRadius:  const BorderRadius.all(Radius.circular(100)),
//               child: Center(
//                 child: FaIcon(
//                   FontAwesomeIcons.userCircle,
//                   color: Theme.of(context).iconTheme.color,
//                   size: 80,
//                 ),
//               ),
//             ),
//           ),
//            const SizedBox(
//             height: 10,
//           ),
//           Text('create_premium_account'.tr, style:  const TextStyle(fontSize: 18)),
//            const SizedBox(
//             height: 10,
//           )
//         ]));
//   }

//   Widget _phoneField() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Expanded(
//           flex: 1,
//           child: Container(
//               decoration: const BoxDecoration(
//                 color: Colors.amber,
//                 borderRadius:  BorderRadius.only(
//                     topLeft: Radius.circular(10),
//                     bottomLeft: Radius.circular(10)),
//               ),
//               padding:
//                    const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
//               height: 60,
//               child:  const Icon(
//                 Icons.phone,
//                 color:  Theme.of(context).primaryColor,
//                 size: 18,
//               )),
//         ),
//         //  SizedBox(width: 5),
//         Expanded(
//           flex: 6,
//           child: Container(
//               decoration: BoxDecoration(
//                   border: const Border(
//                       bottom: BorderSide(
//                           color: Colors.amber, width: 2)),
//                   color: Theme.of(context).primaryColor),
//               padding:
//                    const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
//               height: 60,
//               child: TextField(
//                   controller: _phoneController,
//                   style:  const TextStyle(fontSize: 18),
//                   decoration: InputDecoration(
//                       errorText: _phoneMessage,
//                       errorStyle:  const TextStyle(height: 0),
//                       border: InputBorder.none,
//                       focusedBorder: InputBorder.none,
//                       hintText: 'phone_number'.tr,
//                       suffixIcon: IconButton(
//                         onPressed: _phoneInfo,
//                         icon: _phoneIcon,
//                         color: _phoneIconColor,
//                       )))),
//         ),
//       ],
//     );
//   }

//   Widget _passwordField() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Expanded(
//           flex: 1,
//           child: Container(
//               decoration: const BoxDecoration(
//                 color: Colors.amber,
//                 borderRadius:  BorderRadius.only(
//                     topLeft: Radius.circular(10),
//                     bottomLeft: Radius.circular(10)),
//               ),
//               padding:
//                    const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
//               height: 60,
//               child:  const Icon(
//                 Icons.lock,
//                 color:  Theme.of(context).primaryColor,
//                 size: 18,
//               )),
//         ),
//         //  SizedBox(width: 5),
//         Expanded(
//           flex: 6,
//           child: Container(
//               decoration: BoxDecoration(
//                   border: const Border(
//                       bottom: BorderSide(
//                           color: Colors.amber, width: 2)),
//                   color: Theme.of(context).primaryColor),
//               padding:
//                    const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
//               height: 60,
//               child: TextField(
//                   controller: _passwordController,
//                   style:  const TextStyle(fontSize: 20),
//                   obscureText: _hidePassword,
//                   decoration: InputDecoration(
//                       border: InputBorder.none,
//                       errorText: _passwordMessage,
//                       errorStyle:  const TextStyle(height: 0),
//                       focusedBorder: InputBorder.none,
//                       hintText: 'password'.tr,
//                       suffixIcon: IconButton(
//                         onPressed: _togglePassword,
//                         icon: _passwordIcon,
//                         color: _passwordIconColor,
//                       )))),
//         ),
//       ],
//     );
//   }

//   Widget _signupButton() {
//     return InkWell(
//         onTap: () {
//           _signUp();
//         },
//         child: Container(
//           padding:  const EdgeInsets.all(1),
//           decoration: const BoxDecoration(
//             color: Colors.amber,
//             borderRadius:  BorderRadius.all(Radius.circular(10)),
//           ),
//           child: Container(
//             decoration: const BoxDecoration(
//               color: Colors.amber,
//               borderRadius:  BorderRadius.only(
//                   topLeft: Radius.circular(10),
//                   bottomLeft: Radius.circular(10)),
//             ),
//             padding:
//                  const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
//             height: 50,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('sign_up'.tr,
//                     style:  const TextStyle(color:  Theme.of(context).primaryColor,
//                       fontSize: 18,
//                     )),
//                  const SizedBox(width: 10),
//                  const Icon(
//                   FontAwesomeIcons.userPlus,
//                   color:  Theme.of(context).primaryColor,
//                   size: 18,
//                 )
//               ],
//             ),
//           ),
//         ));
//   }

//   _deparatorField() {
//     return SizedBox(
//         height: 50,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//                 margin:  const EdgeInsets.only(right: 10),
//                 width: MediaQuery.of(context).size.width * 0.1,
//                 child: Divider(
//                   height: 1,
//                   thickness: 1,
//                   color: Theme.of(context).textTheme.bodyText2.color,
//                 )),
//             Text('have_an_account'.tr),
//             Container(
//                 margin:  const EdgeInsets.only(left: 10),
//                 width: MediaQuery.of(context).size.width * 0.1,
//                 child: Divider(
//                   height: 1,
//                   thickness: 1,
//                   color: Theme.of(context).textTheme.bodyText2.color,
//                 )),
//           ],
//         ));
//   }

//   Widget _signInButton() {
//     return InkWell(
//       onTap: () {
//         setState(() {
//           Navigator.pushReplacement(context,
//               MaterialPageRoute(builder: (context) =>  const SignInPage()))
//               .then((value) => setState(() {}));
//         });
//       },
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//             height: 50,
//             padding:  const EdgeInsets.all(1),
//             decoration:   BoxDecoration(
//               color: Theme.of(context).backgroundColor,
//               borderRadius: const BorderRadius.all(Radius.circular(10)),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('sign_in'.tr,
//                     style:  const TextStyle(color: Colors.black,
//                       fontSize: 18,
//                     )),
//                  const SizedBox(width: 10),
//                  const Icon(
//                   Icons.login,
//                   color: Colors.black,
//                   size: 18,
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
