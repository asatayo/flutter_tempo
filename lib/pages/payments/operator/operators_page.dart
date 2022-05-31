// import 'package:flutter/material.dart';
// import 'package:get/get_utils/src/extensions/internacionalization.dart';
// import 'package:tempo/models/payment_model.dart';
// import 'package:tempo/pages/payments/execution/payment_details.dart';
// import 'package:tempo/preferences/shared_preferences.dart';
// import 'package:tempo/preferences/shared_prefs_fun.dart';

// class OperatorsPage extends StatefulWidget {
//   const OperatorsPage({
//     Key key,
//   }) : super(key: key);

//   @override
//   _OperatorsPage createState() => _OperatorsPage();
// }

// class _OperatorsPage extends State<OperatorsPage> {
//   String _mobileOperator = 'M-PESA';
//   bool _isMpesa = true;
//   bool _isTigoPesa = false;
//   bool _isAirtelMoney = false;
//   bool _isTPesa = false;
//   bool _isHaloPesa = false;
//   String _ussdCode = "*150*00#";
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   _updateSelected(String provider) {
//     setState(() {
//       _mobileOperator = provider;
//       switch (provider) {
//         case 'M-PESA':
//           _isMpesa = true;
//           _isTigoPesa = false;
//           _isAirtelMoney = false;
//           _isTPesa = false;
//           _isHaloPesa = false;
//           _ussdCode = "*150*00#";
//           break;
//         case 'TIGOPESA':
//           _isMpesa = false;
//           _isTigoPesa = true;
//           _isAirtelMoney = false;
//           _isTPesa = false;
//           _isHaloPesa = false;
//           _ussdCode = "*150*01#";
//           break;
//         case 'AIRTELMONEY':
//           _isMpesa = false;
//           _isTigoPesa = false;
//           _isAirtelMoney = true;
//           _isTPesa = false;
//           _isHaloPesa = false;
//           _ussdCode = "*150*60#";
//           break;
//         case 'T-PESA':
//           _isMpesa = false;
//           _isTigoPesa = false;
//           _isAirtelMoney = false;
//           _isTPesa = true;
//           _isHaloPesa = false;
//           _ussdCode = "*150*00#";
//           break;
//         case 'HALOPESA':
//           _isMpesa = false;
//           _isTigoPesa = false;
//           _isAirtelMoney = false;
//           _isTPesa = false;
//           _isHaloPesa = true;
//           _ussdCode = "*150*88#";
//           break;
//         default:
//           _mobileOperator = 'MPESA';
//           _isMpesa = true;
//           _isTigoPesa = false;
//           _isAirtelMoney = false;
//           _isTPesa = false;
//           _isHaloPesa = false;
//           _ussdCode = "*150*00#";
//           break;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Center(
//       child: Scaffold(
//         backgroundColor: Theme.of(context).primaryColor,
//         appBar: AppBar(
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back_ios_outlined,
//                 color: Theme.of(context).textTheme.bodyText2.color),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//           backgroundColor: Theme.of(context).primaryColor,
//           title: Text('continue_with_payment'.tr,
//               style: TextStyle(
//                   color: Theme.of(context).textTheme.bodyText2.color)),
//         ),
//         body: Stack(
//           children: [
//             ListView(
//               children: [
//                 _mobileOperatorOptions(context),
//               ],
//             ),
//             Positioned(bottom: 10, child: _bookButton())
//           ],
//         ),
//       ),
//     ));
//   }

//   _checkTitle(String title) {
//     return SizedBox(
//         height: 40,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//                 margin: const EdgeInsets.only(right: 10),
//                 width: MediaQuery.of(context).size.width * 0.1,
//                 child: Divider(
//                   height: 1,
//                   thickness: 1,
//                   color: Theme.of(context).textTheme.bodyText2.color,
//                 )),
//             Text(
//               title.tr,
//               style: const TextStyle(
//                 fontSize: 18,
//               ),
//             ),
//             Container(
//                 margin: const EdgeInsets.only(left: 10),
//                 width: MediaQuery.of(context).size.width * 0.1,
//                 child: Divider(
//                   height: 1,
//                   thickness: 1,
//                   color: Theme.of(context).textTheme.bodyText2.color,
//                 )),
//           ],
//         ));
//   }

//   Widget _mobileOperatorOptions(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(5),
//       // child: Card(
//       child: Column(
//         children: [
//           _checkTitle('choose_operator'),
//           Container(
//             padding: const EdgeInsets.all(10),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       flex: 1,
//                       child: GestureDetector(
//                         onTap: () {
//                           _updateSelected('M-PESA');
//                         },
//                         child: Card(
//                             color: _isMpesa
//                                 ? Theme.of(context).backgroundColor
//                                 : Theme.of(context).cardColor,
//                             shape: const RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.only(
//                                     topRight: Radius.circular(15),
//                                     topLeft: Radius.circular(15),
//                                     bottomLeft: Radius.circular(15),
//                                     bottomRight: Radius.circular(15))),
//                             margin: const EdgeInsets.only(right: 10),
//                             child: Container(
//                               margin: const EdgeInsets.all(5),
//                               decoration: const BoxDecoration(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(10))),
//                               height: MediaQuery.of(context).size.width / 4,
//                               child: ClipRRect(
//                                 borderRadius:
//                                     const BorderRadius.all(Radius.circular(10)),
//                                 child: Image.asset(
//                                   'assets/images/payments/voda.png',
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                             )),
//                       ),
//                     ),
//                     Expanded(
//                         flex: 1,
//                         child: GestureDetector(
//                           onTap: () {
//                             _updateSelected('TIGOPESA');
//                           },
//                           child: Card(
//                               color: _isTigoPesa
//                                   ? Theme.of(context).backgroundColor
//                                   : Theme.of(context).cardColor,
//                               shape: const RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.only(
//                                       topRight: Radius.circular(15),
//                                       topLeft: Radius.circular(15),
//                                       bottomLeft: Radius.circular(15),
//                                       bottomRight: Radius.circular(15))),
//                               margin: const EdgeInsets.only(right: 10),
//                               child: Container(
//                                 margin: const EdgeInsets.all(5),
//                                 decoration: const BoxDecoration(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(10))),
//                                 height: MediaQuery.of(context).size.width / 4,
//                                 child: ClipRRect(
//                                   borderRadius: const BorderRadius.all(
//                                       Radius.circular(10)),
//                                   child: Image.asset(
//                                     'assets/images/payments/tigo.png',
//                                     fit: BoxFit.fill,
//                                   ),
//                                 ),
//                               )),
//                         )),
//                     Expanded(
//                       flex: 1,
//                       child: GestureDetector(
//                           onTap: () {
//                             _updateSelected('AIRTELMONEY');
//                           },
//                           child: Card(
//                               color: _isAirtelMoney
//                                   ? Theme.of(context).backgroundColor
//                                   : Theme.of(context).cardColor,
//                               shape: const RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.only(
//                                       topRight: Radius.circular(15),
//                                       topLeft: Radius.circular(15),
//                                       bottomLeft: Radius.circular(15),
//                                       bottomRight: Radius.circular(15))),
//                               margin: const EdgeInsets.only(right: 10),
//                               child: Container(
//                                 margin: const EdgeInsets.all(5),
//                                 decoration: const BoxDecoration(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(10))),
//                                 height: MediaQuery.of(context).size.width / 4,
//                                 child: ClipRRect(
//                                   borderRadius: const BorderRadius.all(
//                                       Radius.circular(10)),
//                                   child: Image.asset(
//                                     'assets/images/payments/airtel.jpg',
//                                     fit: BoxFit.fill,
//                                   ),
//                                 ),
//                               ))),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                         flex: 1,
//                         child: GestureDetector(
//                           onTap: () {
//                             _updateSelected('T-PESA');
//                           },
//                           child: Card(
//                               color: _isTPesa
//                                   ? Theme.of(context).backgroundColor
//                                   : Theme.of(context).cardColor,
//                               shape: const RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.only(
//                                       topRight: Radius.circular(15),
//                                       topLeft: Radius.circular(15),
//                                       bottomLeft: Radius.circular(15),
//                                       bottomRight: Radius.circular(15))),
//                               margin: const EdgeInsets.only(right: 10),
//                               child: Container(
//                                 margin: const EdgeInsets.all(5),
//                                 decoration: const BoxDecoration(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(10))),
//                                 height: MediaQuery.of(context).size.width / 4,
//                                 child: ClipRRect(
//                                   borderRadius: const BorderRadius.all(
//                                       Radius.circular(10)),
//                                   child: Image.asset(
//                                     'assets/images/payments/ttcl.jpg',
//                                     fit: BoxFit.fill,
//                                   ),
//                                 ),
//                               )),
//                         )),
//                     Expanded(
//                       flex: 1,
//                       child: GestureDetector(
//                           onTap: () {
//                             _updateSelected('HALOPESA');
//                           },
//                           child: Card(
//                               color: _isHaloPesa
//                                   ? Theme.of(context).backgroundColor
//                                   : Theme.of(context).cardColor,
//                               shape: const RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.only(
//                                       topRight: Radius.circular(15),
//                                       topLeft: Radius.circular(15),
//                                       bottomLeft: Radius.circular(15),
//                                       bottomRight: Radius.circular(15))),
//                               margin: const EdgeInsets.only(right: 10),
//                               child: Container(
//                                 margin: const EdgeInsets.all(5),
//                                 decoration: const BoxDecoration(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(10))),
//                                 height: MediaQuery.of(context).size.width / 4,
//                                 child: ClipRRect(
//                                   borderRadius: const BorderRadius.all(
//                                       Radius.circular(10)),
//                                   child: Image.asset(
//                                     'assets/images/payments/halotel.png',
//                                     fit: BoxFit.fill,
//                                   ),
//                                 ),
//                               ))),
//                     ),
//                     Expanded(
//                         flex: 1,
//                         child: Card(
//                             shape: const RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.only(
//                                     topRight: Radius.circular(15),
//                                     topLeft: Radius.circular(15),
//                                     bottomLeft: Radius.circular(15),
//                                     bottomRight: Radius.circular(15))),
//                             margin: const EdgeInsets.only(right: 10),
//                             child: Container(
//                               margin: const EdgeInsets.all(5),
//                               decoration: const BoxDecoration(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(10))),
//                               height: MediaQuery.of(context).size.width / 4,
//                               // child: ClipRRect(
//                               //   borderRadius:
//                               //       BorderRadius.all(Radius.circular(10)),
//                               //   child: Image.asset(
//                               //     'assets/images/payments/halotel.png',
//                               //     fit: BoxFit.fill,
//                               //   ),
//                               // ),
//                             ))),
//                   ],
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _bookButton() {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
//       child: InkWell(
//         onTap: () async {
//           PaymentModel paymentModel =
//               await _storeDataToPref(_mobileOperator, _ussdCode);
//               if(paymentModel!=null){
//                  Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         PaymentsPage(paymentModel: paymentModel)));
//               }else{
//                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               content: Row(children: [
//                 Text('invalid_cart'.tr),
//               ]),
//             ));
//               }
         
//         },
//         child: Container(
//           decoration: const BoxDecoration(
//             color: Colors.amber,
//             borderRadius: BorderRadius.all(Radius.circular(30)),
//           ),
//           padding:
//               const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
//           height: 50,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text('$_mobileOperator  | ',
//                   style: const TextStyle(color: Colors.black, fontSize: 16)),
//               Text('continue'.tr,
//                   style: const TextStyle(color: Colors.black, fontSize: 16)),
//               const SizedBox(width: 10),
//               const Icon(
//                 Icons.arrow_forward_ios_outlined,
//                 color: Colors.black,
//                 size: 20,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<PaymentModel> _storeDataToPref(
//       String mobileOperator, String ussdCode) async {
//     await AppData().storeValue('BOOKING_OPERATOR', mobileOperator);
//     await AppData().storeValue('BOOKING_USSD', ussdCode);
//     List<PaymentModel> paymentModel = await paymentDataToModel();
//     // print(paymentModel.length);
//     //  print(paymentModel.first.price);
//     return Future.value(paymentModel.first);
//   }
// }
