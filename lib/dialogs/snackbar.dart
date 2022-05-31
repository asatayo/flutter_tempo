import 'package:flutter/material.dart';

class AppSnackBar{
  final BuildContext context;
  AppSnackBar({required this.context}); 
   showSnackBar(String message, int duration){
     ScaffoldMessenger.of(context).showSnackBar( SnackBar(
       duration: Duration(seconds: duration),
        content: Text(message)));
   }
}