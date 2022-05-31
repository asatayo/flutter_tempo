import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class DescriptionDialog extends StatefulWidget {
  final String description;
   const DescriptionDialog({Key? key,  required this.description}) : super(key: key);
  @override
  DescriptionDialogState createState() => DescriptionDialogState();
}

class DescriptionDialogState extends State<DescriptionDialog> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        insetPadding:  const EdgeInsets.all(30),
        backgroundColor: Theme.of(context).cardColor,
        children: [
             Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                Container(
                    padding:  const EdgeInsets.all(15),
                    child: Text(widget.description, style: const TextStyle(fontSize: 11)),

                    ),
               
                Container(
                    height: 60,
                    padding:  const EdgeInsets.only(
                        left: 10, right: 10, top: 5, bottom: 5),
                    child:  InkWell(
                        onTap: () {
                          Navigator.pop(context);
                    
                        },
                        child: Container(
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 5),
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('ok'.tr,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 12)),
                              ],
                            ),
                          ),
                        ))
                    )
               ]
          )
        ]);
  }
}
