import 'package:flutter/material.dart';

import 'componets/body.dart';

class ReceiptTabView extends StatelessWidget {
  final Function notifyParent;
  const ReceiptTabView({Key? key, required this.notifyParent}) : super(key: key);
  @override
  @override
  Widget build(BuildContext context) {
    return  Center(
        child: SafeArea(
      child: Scaffold(
        body: Body(notifyParent:notifyParent),
      ),
    ));
  }
}
