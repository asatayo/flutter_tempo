import 'package:flutter/material.dart';

class Image2Icon extends StatefulWidget {
  final String asset; 
  final double size; 
  final Color color;

  const Image2Icon({Key? key, required this.asset, required this.size, required this.color}) : super(key: key);
  @override
  State<Image2Icon> createState() => _Image2IconState();
}

class _Image2IconState extends State<Image2Icon> {
  @override
  Widget build(BuildContext context) {
    return ImageIcon(
      AssetImage(widget.asset),
      size: widget.size,
      color:widget.color,
    );
  }
}