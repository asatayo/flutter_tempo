// import 'dart:convert';
// import 'dart:io';

// import 'package:tempo/http/exceptions.dart';

// class ApiBaseHelper {
//     String _joinedURL;
//   Uri _requestURI;
//   // Future<dynamic> get(String url) async {
//   //   Uri uri = Uri.parse(_baseUrl+url);
//   //   var responseJson;
//   //   try {
//   //     final response = await http.get(uri);
//   //     responseJson = _returnResponse(response);
//   //   } on SocketException {
//   //     throw FetchDataException('No Internet connection');
//   //   }
//   //   return responseJson;
//   // }

//   dynamic _returnResponse(http.Response response) {
//     switch (response.statusCode) {
//       case 200:
//         var responseJson = json.decode(response.body.toString());
//         return responseJson;
//       case 400:
//         throw BadRequestException(response.body.toString());
//       case 401:
//       case 403:
//         throw UnauthorisedException(response.body.toString());
//       case 500:
//       default:
//         throw FetchDataException(
//             'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
//     }
//   }

//   Future<dynamic> getPublic(String api) async {
//     _joinedURL = _baseServerURL() + api;
//     _requestURI = Uri.parse(_joinedURL);
//     // ignore: prefer_typing_uninitialized_variables
//     var responseJson;
//     try {
//      final response  = await http.get(_requestURI);
//      responseJson = _returnResponse(response);

//       // ignore: empty_catches
//     } on SocketException {
//       throw FetchDataException('No Internet connection');
//     }
//     return responseJson;
//   }

//   Future<dynamic> getAuthdata(String api, String token) async {
//     _joinedURL = _baseServerURL() + api;
//     _requestURI = Uri.parse(_joinedURL);
//     // ignore: prefer_typing_uninitialized_variables
//     var responseJson;
//     try {
//       final response = await http.get(_requestURI, headers: _setHeader(token));
//            responseJson = _returnResponse(response);

//     } on SocketException {
//       throw FetchDataException('No Internet connection');
//     }
//     return responseJson;
//   }

//   Future<dynamic> postPublicRequest(String api, dynamic data) async {
//     final String joinedURL = _baseServerURL() + api;
//     final requestURL = Uri.parse(joinedURL);
//     // ignore: prefer_typing_uninitialized_variables
//     var responseJson;
// try{
//     final response = await http.post(
//       requestURL,
//       headers: _specifyHeader(),
//       body: _setBody(data),
//     );
//                responseJson = _returnResponse(response);

//     } on SocketException {
//       throw FetchDataException('No Internet connection');
//     }

//     return responseJson;
//   }

//   Future<dynamic>  authRequest(String api, dynamic data) async {

//     final String joinedURL = _baseServerURL() + api;
//     final requestURL = Uri.parse(joinedURL);
//      // ignore: prefer_typing_uninitialized_variables
//      var responseJson;
//     try {
//       final response  = await http.post(
//       requestURL,
//       headers: _specifyHeader(),
//       body: _setBody(data),
//     );
//                    responseJson = _returnResponse(response);

//     } on SocketException {
//       throw FetchDataException('No Internet connection');
//     }
//     return responseJson;
//   }

//   _specifyHeader() {
//     return {
//       "Content-type": "aplication/json; charset=utf-8",
//       'Accept': 'aplication/json',
//     };
//   }

//   _setHeader(String token) {
//     return {
//       'Content-type': 'aplication/json',
//       'Accept': 'aplication/json',
//       'Authorization': 'Bearer $token'
//     };
//   }

//   _setBody(data) {
//     return jsonEncode(data);
//   }

//   // String _baseServerURL() {
//   //   if (Platform.isAndroid) {
//   //     return 'http://10.0.2.2:8000/api/';
//   //   } else {
//   //     return 'http://10.0.2.2:8000/api/';
//   //   }
//   // }

//   // String fileBaseUrl() {
//   //   if (Platform.isAndroid) {
//   //     return 'http://10.0.2.2:8000/';
//   //   } else {
//   //     return 'http://10.0.2.2:8000/';
//   //   }
//   // }

//   String _baseServerURL() {
//     if (Platform.isAndroid) {
//       return 'http://192.168.43.20:8000/api/';
//     } else {
//       return 'http://192.168.43.20:8000/api/';
//     }
//   }

//   String fileBaseUrl() {
//     if (Platform.isAndroid) {
//       return 'http://192.168.43.20:8000/';
//     } else {
//       return 'http://192.168.43.20:8000/';
//     }
//   }
// }
