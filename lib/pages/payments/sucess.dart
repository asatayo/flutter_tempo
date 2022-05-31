
// import 'package:flutter/material.dart';
// import 'package:tempo/constants/constants.dart';
// import 'package:tempo/icons/icons.dart';
// import 'package:tempo/pages/dashboard/dashboard_page.dart';

// class SuccessX extends StatefulWidget {
//   final String category;
//   const Success({Key key, this.category}) : super(key: key);

//   @override
//   _SuccessState createState() => _SuccessState();
// }

// class _SuccessState extends State<Success> {

//   double height;
//   double width;
//   double total = 0;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     height = MediaQuery.of(context).size.height - 140;
//     width = MediaQuery.of(context).size.width;
//     return SafeArea(
//         child: Scaffold(
//       body: Center(child: SingleChildScrollView(
//         physics: const AlwaysScrollableScrollPhysics(),
//         child:  Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             azamPay(),
//             confirmButton()
//             //  confirmButton()
//           ],
//         ),
//       ),
//     )));
//   }

  

//   azamPay() {
//     return Padding(
//         padding: const EdgeInsets.only(left: 20, top: 40, right: 20),
//         child: Column(
//           children: [
//             Container(
//               child:  const Padding(padding: EdgeInsets.all(15), child: Image2Icon(asset: 'assets/check.png', color: Colors.white, size: 30)) ,
//               margin: const EdgeInsets.all(10),
//               decoration:  BoxDecoration(
//                  border: Border.all(color: primaryColor, width: 5),
//                 shape: BoxShape.circle,
//                 color: primaryColor,
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Colors.grey,
//                     spreadRadius: 1,
//                     blurRadius: 3,
//                   ),
//                 ],
//               ),
//               height: 80,
//               width: 80,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Text(
//               "Thank you for shopping with us",
//               style: black16MediumTextStyle,
//             ),
//               const SizedBox(
//               height: 20,
//             ),
//           ],
//         ));
//   }

//   confirmButton() {
//     return Padding(
//         padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
//         child: InkWell(
//             onTap: () {
                
//                 Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) =>   const DashboardPage()));
//             },
//             child: Container(
//               height: 58,
//               alignment: Alignment.center,
//               padding: const EdgeInsets.symmetric(horizontal: 50),
//               decoration: BoxDecoration(
//                 color: primaryColor,
//                 borderRadius: BorderRadius.circular(5),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.white.withOpacity(0.6),
//                     spreadRadius: 1,
//                     blurRadius: 1,
//                   ),
//                 ],
//               ),
//               child: Text(
//                 "Back to Orders",
//                 style: white18SemiBoldTextStyle,
//               ),
//             )));
//   }
// }
