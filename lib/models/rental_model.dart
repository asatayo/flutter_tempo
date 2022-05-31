
import 'package:tempo/http/api.dart';
import 'package:tempo/models/thumbnail_model.dart';

class RentalModel {
  final bool hasRoom;
  final String houseId;
  final String price;
  final bool status;
  final bool visibility;
  final String name;
  final String category;
  final String description;
  final String instruction;
  final String bannerThumbNail;
  final String identity;
  final String region;
  final String district;
  final String transport;
  final String months;
  final String rooms;
  final bool electricity;
  final bool water;
  final bool kitchen;
  final String createdat;
  final List<ThumbnailModel> thumbnails;
  RentalModel({
    required this.hasRoom,
    required this.transport,
    required this.rooms,
    required this.months,
    required this.electricity,
    required this.water,
    required this.kitchen,
    required this.houseId,
    required this.name,
    required this.category,
    required this.description,
    required this.instruction,
    required this.thumbnails,
    required this.bannerThumbNail,
    required this.createdat,
    required this.identity,
    required this.status,
    required this.visibility,
    required this.region,
    required this.district,
    required this.price,
  });

  factory RentalModel.fromJson(Map<String, dynamic> json) {
    var list = json['thumbnails'] as List;
    List<ThumbnailModel> imageList =
    list.map((i) => ThumbnailModel.fromJson(i)).toList();
    return RentalModel(
        hasRoom: json['hasroom']==1,
        houseId: json['id'].toString(),
        name: json['name'],
        price: json['price'].toString(),
        category: json['category'],
        description: json['description'],
        instruction: json['instruction'],
        region: json['region']['name'],
        district: json['district']['name'],
        bannerThumbNail: baseServerFile + json['banner'],
        createdat: json['created_at'],
        identity: json['identity'],
        status: json['status'] == 1,
        thumbnails: imageList,
        visibility: json['visibility'] == 1 ? true : false,
        electricity: json['electricity'] == 1 ? true : false,
        water: json['water'] == 1 ? true : false,
        kitchen: json['kitchen'] == 1 ? true : false,
        transport: json['transport'],
        months: json['min_months'].toString(),
        rooms: json['rooms'].toString());
  }
}
