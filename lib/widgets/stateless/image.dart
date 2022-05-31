import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageData extends StatelessWidget {
  final String imageUrl;
  const ImageData({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      filterQuality: FilterQuality.low,
      fit: BoxFit.cover,
       placeholder: (context, url) => const Center(
              child: SizedBox(
                  height: 50,
                  width: 50,
                  child: Center(child: CircularProgressIndicator()))),
      errorWidget: (context, url, error) =>
          const Icon(Icons.broken_image_sharp, size: double.infinity),
    );

    // return Image.network(
    //   imageUrl,
    //   fit: BoxFit.cover,
    //   errorBuilder:
    //       (BuildContext context, Object error, StackTrace stackTrace) {
    //     return Image.asset('assets/images/error.png');
    //   },
    //   filterQuality: FilterQuality.low,
    //     loadingBuilder: (BuildContext context, Widget child,
    //         ImageChunkEvent loadingProgress) {
    //       return const SizedBox(
    //           height: double.infinity,
    //           width: double.infinity,
    //           child: Center(child: Center(child: CircularProgressIndicator())));
    //     });


    // return FadeInImage.assetNetwork(
    //   image: imageUrl,
    //   fit: BoxFit.cover,
    //   placeholder: 'assets/images/loading.gif',
    //   imageErrorBuilder:
    //       (BuildContext context, Object error, StackTrace stackTrace) {
    //     return Image.asset('assets/images/error.png', height: 100, width: 100);
    //   },
    // );
  }
}

class ImageDataSized extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  const ImageDataSized({Key? key, required this.imageUrl, required this.width, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
       filterQuality: FilterQuality.low,
      imageUrl: imageUrl,
      height: height,
      width: width,
      placeholder: (context, url) =>  const SizedBox(height: double.infinity, width: double.infinity, child: Center(
          child: Center(child: CircularProgressIndicator()))),
      errorWidget: (context, url, error) =>  const Icon(Icons.info),
    );

    // return Image.network(imageUrl,
    //     height: height,
    //     width: height,
    //     errorBuilder:
    //         (BuildContext context, Object error, StackTrace stackTrace) {
    //       return Image.asset('assets/images/error.png',
    //           height: height, width: width);
    //     },
    //     filterQuality: FilterQuality.low,
    //     fit: BoxFit.cover,
    //     loadingBuilder: (BuildContext context, Widget child,
    //         ImageChunkEvent loadingProgress) {
    //       return const SizedBox(
    //           height: double.infinity,
    //           width: double.infinity,
    //           child: Center(child: Center(child: CircularProgressIndicator())));
    //     });

    // return FadeInImage.assetNetwork(
    // placeholder: 'assets/images/loading.gif',
    // image: imageUrl,
    // height: height,
    // width: height,
    // imageErrorBuilder:
    //     (BuildContext context, Object error, StackTrace stackTrace) {
    //   return Image.asset('assets/images/error.png',
    //       height: height, width: width);
    // });
  }
}
