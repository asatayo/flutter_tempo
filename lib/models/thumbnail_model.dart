import 'package:tempo/http/api.dart';
class ThumbnailModel {
  final String caption;
  final String imageuUrl;
  ThumbnailModel({required this.caption, required this.imageuUrl});
  factory ThumbnailModel.fromJson(Map<String, dynamic> parsedJson) {
    return ThumbnailModel(
      caption: parsedJson['caption'] ?? 'No caption',
      imageuUrl: baseServerFile + parsedJson['thumbnail'],
    );
  }
}
