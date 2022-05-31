import 'package:tempo/http/api.dart';
import 'package:tempo/models/thumbnail_model.dart';

class ServiceModel {
  final String serviceId;
  final bool status;
  final String visibility;
  final String name;
  final String type;
  final String category;
  final String? description;
  final String? instruction;
  final String logoThumbNail;
  final String bannerThumbNail;
  final String identity;
  final String region;
  final String district;
  final String? map;
  final String website;
  final String createdat;
  final List<ThumbnailModel> thumbnails;
  ServiceModel({
    required this.serviceId,
    required this.name,
    required this.type,
    required this.category,
     this.description,
     this.instruction,
    required this.thumbnails,
    required this.bannerThumbNail,
    required this.createdat,
    required this.identity,
    required this.logoThumbNail,
    this.map,
    required this.status,
    required this.visibility,
    required this.website,
    required this.region,
    required this.district,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    var list = json['thumbnails'] as List;
    List<ThumbnailModel> imageList =
        list.map((i) => ThumbnailModel.fromJson(i)).toList();
    return ServiceModel(
      // serviceId: "1",
      // price: 100,
      // name: "Random data",
      // type: "Random data",
      // category:  "Random data",
      // description:  "Random data",
      // instruction:  "Random data",
      // region:  "Random data",
      // district:  "Random data",
      // bannerThumbNail: baseServerFile +  "Random data",
      // createdat:  "Random data",
      // identity:  "Random data",
      // logoThumbNail: baseServerFile +  "Random data",
      // map: "Random data",
      // status: json['status']==1,
      // thumbnails: [],
      // visibility: "Random data",
      // website:  "Random data",

       serviceId: json['id'].toString(),
      name: json['name'],
      type: json['type'],
      category: json['category'],
      description: json['description'],
      instruction: json['instruction'],
      region: json['region']['name'],
      district: json['district']['name'],
      bannerThumbNail: baseServerFile + json['banner'],
      createdat: json['created_at'],
      identity: json['identity'],
      logoThumbNail: baseServerFile + json['logo'],
      map: json['map'],
      status: json['status']==1,
      thumbnails: imageList,
      visibility: json['visibility'].toString(),
      website: json['website'],
    );
  }



       
}
