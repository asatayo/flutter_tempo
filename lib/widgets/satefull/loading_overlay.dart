import 'package:flutter/material.dart';

class LoadingDialog extends StatefulWidget {
   const LoadingDialog({Key? key}) : super(key: key);

  @override
  LoadingDialogState createState() => LoadingDialogState();
}

class LoadingDialogState extends State<LoadingDialog> {
  @override
  Widget build(BuildContext context) {
    return  SimpleDialog(
      insetPadding: EdgeInsets.all(MediaQuery.of(context).size.width/3),
      backgroundColor: Colors.transparent,
        children: [
           SizedBox(
            height: 200,
            width: 100,
            child: Image.asset('assets/images/loader.gif', width: 50,),
          )
        ]
        );
  }
}

showLoading(BuildContext context){
  showDialog(
      useSafeArea: true,
      context: context,
      builder: (_) =>  const LoadingDialog());
}