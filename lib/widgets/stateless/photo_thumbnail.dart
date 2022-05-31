import 'package:flutter/material.dart';
import 'package:tempo/widgets/stateless/image.dart';
class PhotoThumbnailAdapter extends StatelessWidget {
  final String imageUrl;
  const PhotoThumbnailAdapter({Key? key,  required this.imageUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: ImageData(imageUrl:imageUrl),
      ),
    );
  }
}
