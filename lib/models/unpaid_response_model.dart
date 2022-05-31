// import 'package:tempo/http/api.dart';
// import 'package:tempo/models/landlord_model.dart';
// import 'package:tempo/models/thumbnail_model.dart';
// import 'package:tempo/models/unpaid_model.dart';

// class UnpaidResponseModel {
//   final bool status;
//   final bool isreference;
//   final bool isactive;
//   String? reference;

//   final UnpaidRentalModel unpaidRentalModel;
//   UnpaidResponseModel(
//       {required this.status,
//       required this.isreference,
//       required this.isactive,
//         this.reference,
//       required this.unpaidRentalModel});

//   factory UnpaidResponseModel.fromJson(Map<String, dynamic> json) {
//     UnpaidRentalModel unpaidRentalModel;
//     unpaidRentalModel = UnpaidRentalModel.fromJson(json['rental']);
//     return UnpaidResponseModel(
//         status: json['status'],
//         isreference: json['isreference'],
//         isactive: json['isactive'],
//         reference: json['reference'],
//         unpaidRentalModel: unpaidRentalModel);
//   }
// }
