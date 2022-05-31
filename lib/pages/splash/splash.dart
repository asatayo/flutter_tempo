// import 'dart:async';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_utils/src/extensions/internacionalization.dart';

// class SplashPage extends StatefulWidget {
//    SplashPage({Key key}) : super(key: key);
//   @override
//   _SplashPageState createState() => _SplashPageState();
// }

// class _SplashPageState extends State<SplashPage> {
//   BuildContext mContext;
//   @override
//   void initState() {
//     super.initState();
//     startTimeout();
//   }

//   startTimeout() {
//     return Timer( Duration(seconds: 3), _openNextPage);
//   }

//   _openNextPage() async {
    
//     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  HomePage()));
//   }

//   @override
//   Widget build(BuildContext context) {
//     mContext = context;
//     return Scaffold(
//       backgroundColor: Theme.of(context).primaryColor,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//                 width: 150.0,
//                 height: 60.0,
//                 // ignore: unnecessary_new, prefer__ructors
//                 decoration: new BoxDecoration(
//                     shape: BoxShape.rectangle,
//                     // ignore: prefer__ructors
//                     image: DecorationImage(
//                         fit: BoxFit.fill,
//                         // ignore: prefer__ructors
//                         image: AssetImage('assets/images/logo.png')))),
//             // ignore: prefer__ructors
//             Padding(
//               padding:  EdgeInsets.only(top: 10.0),
//               // ignore: prefer__ructors
//               child: Text(
//                 'smart_tempo'.tr,
//                 // ignore: prefer__ructors
//                 style: TextStyle(fontSize: 18),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

