import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xffc67e69);
// const kPrimaryColor = Color(0xFFFF7643);

const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF4C4A4A);
const kTextColor = Color(0xFF444343);
const kBorderColor = Color(0xffc67e69);

const kAnimationDuration = Duration(milliseconds: 300);

const headingStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
String phoneErrorMessage = "";
String passcodeErrorMessage = "";

String nameErrorMessage = "";
String priceErrorMessage = "";

String descriptionErrorMessage = "";

String imageErrorMessage = "";
String quantityErrorMessage = "";

const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

bool isValidPhone(String value) {
  bool isValid = true;
  String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = RegExp(patttern);
  if (value.isEmpty) {
    isValid = false;
    phoneErrorMessage = 'enter_phone';
  } else if (!regExp.hasMatch(value)) {
    isValid = false;
    phoneErrorMessage = 'invalid_phone';
  }
  return isValid;
}

bool isValidInput(String value) {
  bool isValid = true;
  if (value.isEmpty) {
    isValid = false;
    phoneErrorMessage = 'enter_phone';
  }
  return isValid;
}

bool isValidPrice(String value) {
  bool isValid = true;
  if (value.isEmpty) {
    isValid = false;
    phoneErrorMessage = 'enter_phone';
  }
  return isValid;
}

bool isValidPassCode(String code) {
  bool isValid = true;
  if (code.isEmpty) {
    isValid = false;
    passcodeErrorMessage = 'enter_passcode';
  } else if (code.length < 4) {
    isValid = false;
    passcodeErrorMessage = 'short_passcode';
  }
  return isValid;
}

final otpInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 0),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);
const formInputPadding =
    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 5);
OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: kBorderColor, width: 0.5),
  );
}

const newFormInputPadding =
    EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 5);
OutlineInputBorder newOutlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: kBorderColor, width: 0.5),
  );
}

const searchPadding = EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 5);
OutlineInputBorder searchOutlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: kBorderColor, width: 0.5),
  );
}

const clearSearchPadding =
    EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 15);
OutlineInputBorder clearSearch() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: kBorderColor, width: 0.5),
  );
}

const clearMainSearchPadding =
    EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 5);
OutlineInputBorder clearMainSearch() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: kBorderColor, width: 0.5),
  );
}

const formInputPaddingTwo =
    EdgeInsets.only(left: 10, right: 20, top: 5, bottom: 5);
OutlineInputBorder outlineInputBorderTwo() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: kBorderColor, width: 0.5),
  );
}
