// import 'package:tempo/http/api.dart';
// import 'package:tempo/models/thumbnail_model.dart';

// class UnpaidRentalModel {
//   final bool hasRoom;
//   final String houseId;
//   final String price;
//   final bool status;
//   final bool visibility;
//   final String name;
//   final String category;
//   final String description;
//   final String instruction;
//   final String bannerThumbNail;
//   final String identity;
//   final String region;
//   final String district;
//   final String transport;
//   final String days;
//   final String rooms;
//   final bool electricity;
//   final bool water;
//   final bool kitchen;
//   final String createdat;
//   final List<ThumbnailModel> thumbnails;
//   UnpaidRentalModel({
//     required this.hasRoom,
//     required this.transport,
//     required this.rooms,
//     required this.days,
//     required this.electricity,
//     required this.water,
//     required this.kitchen,
//     required this.houseId,
//     required this.name,
//     required this.category,
//     required this.description,
//     required this.instruction,
//     required this.thumbnails,
//     required this.bannerThumbNail,
//     required this.createdat,
//     required this.identity,
//     required this.status,
//     required this.visibility,
//     required this.region,
//     required this.district,
//     required this.price,
//   });

//   factory UnpaidRentalModel.fromJson(Map<String, dynamic> json) {
//     var list = json['thumbnails'] as List;
//     List<ThumbnailModel> imageList = [];

//      if(list.isNotEmpty){
//         imageList =  list.map((i) => ThumbnailModel.fromJson(i)).toList();
//      }
//     return UnpaidRentalModel(
//       name: "Nosto Area House",
//       price: "800",
//       hasRoom: true,
//       houseId: "1",
//       category: json['category'],
//       electricity:  false,
//       water: false,
//       kitchen: false,
//       transport: "tsdfgdsh",
//       rooms: "45",
//       description: "3456467tturiurtu",
//       instruction: "4364356",
//       region: "463665",
//       district: "4365563465",
//       bannerThumbNail: "3463563456",
//       createdat: "325534653",
//       identity: "52353254",
//       status:  false,
//       thumbnails: imageList,
//       visibility:  false,
//       days: "5",

//     );
//   }
// }
