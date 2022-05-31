import 'package:tempo/models/thumbnail_model.dart';

class RoomModel {
  final String roomId;
  final String roomName;
  final String roomType;
  final String roomIdentity;
  final String roomDescription;
  final String price;
  final String hours;
  final String roomServiceId;
  final String roomStatus;
  final List<ThumbnailModel> roomThumbNails;
  RoomModel({required this.roomId, required this.roomName, required this.roomType, required this.roomIdentity, required this.roomDescription, required this.price, required this.hours, required this.roomServiceId, required this.roomStatus, required this.roomThumbNails});

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    var list = json['thumbnails'] as List;
    List<ThumbnailModel> roomThumbNailsList =
        list.map((i) => ThumbnailModel.fromJson(i)).toList();
    return RoomModel(
      roomId: json['id'].toString(),
      roomServiceId: json['service_id'].toString(),
      roomName: json['name'],
      roomType: json['type'],
      roomIdentity: json['identity'],
      roomDescription: json['description'],
      price: json['price'].toString(),
      hours: json['min'].toString(),
      roomStatus: json['status'].toString(),
      roomThumbNails: roomThumbNailsList,
    );
  }
}
