import 'package:flutter/material.dart';

class LoadingWithMessage extends StatefulWidget {
  final String message;
   const LoadingWithMessage({
    Key? key,
     required this.message,
  }) : super(key: key);

  @override
  LoadingWithMessageState createState() => LoadingWithMessageState();
}

class LoadingWithMessageState extends State<LoadingWithMessage> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        insetPadding: EdgeInsets.all(MediaQuery.of(context).size.width / 3),
        backgroundColor: Colors.transparent,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //  SizedBox(
                //   height: 200,
                //   width: 100,
                //   child: SizedBox(
                //       height: 50,
                //       width: 50,
                //       child: CircularProgressIndicator()),
                // ),
               
                const SizedBox(
                  height: 80,
                  width: 80,
                  child: CircularProgressIndicator(),
                ),
                 const Divider(height: 1),
                 Text(widget.message),
              ],
            ),
          ),
        ]);
  }
}

showLoadingWithMessage(BuildContext context, String message) {
  showDialog(
      useSafeArea: true,
      context: context,
      builder: (_) =>  LoadingWithMessage(message: message));
}
