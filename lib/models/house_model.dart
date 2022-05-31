
import 'package:tempo/http/api.dart';
import 'package:tempo/models/thumbnail_model.dart';

class HouseModel {
  final String houseId;
  final String price;
  final bool status;
  final bool visibility;
  final String name;
  final String type;
  final String category;
  final String description;
  final String instruction;
  final String bannerThumbNail;
  final String identity;
  final String region;
  final String district;
  final String map;
  final String transport;
  final String days;
  final String rooms;
  final bool electricity;
  final bool water;
  final bool kitchen;
  final String createdat;
  final List<ThumbnailModel> thumbnails;
  HouseModel({
    required this.transport,
    required this.rooms,
    required this.days,
    required this.electricity,
    required this.water,
    required this.kitchen,
    required this.houseId,
    required this.name,
    required this.type,
    required this.category,
    required this.description,
    required this.instruction,
    required this.thumbnails,
    required this.bannerThumbNail,
    required this.createdat,
    required this.identity,
    required this.map,
    required this.status,
    required this.visibility,
    required this.region,
    required this.district,
    required this.price,
  });

  factory HouseModel.fromJson(Map<String, dynamic> json) {
    var list = json['thumbnails'] as List;
    List<ThumbnailModel> imageList =
        list.map((i) => ThumbnailModel.fromJson(i)).toList();
    return HouseModel(
        houseId: json['id'].toString(),
        name: json['name'],
        price: json['price'].toString(),
        type: json['type'],
        category: json['category'],
        description: json['description'],
        instruction: json['instruction'],
        region: json['region']['name'],
        district: json['district']['name'],
        bannerThumbNail: baseServerFile + json['banner'],
        createdat: json['created_at'],
        identity: json['identity'],
        map: json['map'],
        status: json['status'] == 1 ? true : false,
        thumbnails: imageList,
        visibility: json['visibility'] == 1 ? true : false,
        electricity: json['electricity'] == 1 ? true : false,
        water: json['water'] == 1 ? true : false,
        kitchen: json['kitchen'] == 1 ? true : false,
        transport: json['transport'],
        days: json['days'].toString(),
        rooms: json['rooms'].toString());
  }
}
