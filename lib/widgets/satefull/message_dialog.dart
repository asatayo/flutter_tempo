import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
class MessageDialog extends StatefulWidget {
  final String title;
  final String message;
  final Icon icon;
   const MessageDialog(
      {Key? key,
       required this.title,
       required this.message,
       required this.icon})
      : super(key: key);
  @override
  MessageDialogState createState() => MessageDialogState();
}

class MessageDialogState extends State<MessageDialog> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        insetPadding:  const EdgeInsets.all(30),
        backgroundColor: Theme.of(context).cardColor,
        children: [
          Column(children: [
            Container(
                padding:  const EdgeInsets.all(15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          padding:  const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  widget.icon,
                                   const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.title,
                                    style:  const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                               const SizedBox(
                                height: 10,
                              ),
                              //  Divider(
                              //   height: 1,
                              //   color: Theme.of(context)
                              //       .textTheme
                              //       .bodyText2!
                              //       .color,
                              // ),
                              Text(
                                widget.message,
                                style:  const TextStyle(fontSize: 11),
                              )
                            ],
                          )),
                       const SizedBox(height: 20),
                      InkWell(
                          onTap: () {


        //                     Navigator.pop(context);
        //                     if (isRegistredSucessfully) {
        //                       currentIndexPage = 3;
        //                         Navigator.pop(context);
        //                         Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>  const TermsConditionsPage())).then((value) => setState(() {}));
        //                     }
        //                      if(isLogedInSuccessfully){
        //                         setState(() {
        //   currentIndexPage = 1;
        //   Navigator.pushReplacement(context,
        //           MaterialPageRoute(builder: (context) =>  const DashboardPage()))
        //       .then((value) => setState(() {}));
        // });
        //                      }
                          },
                          child: Container(
                            padding:  const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Theme.of(context).backgroundColor,
                              borderRadius:
                                   const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Container(
                              padding:  const EdgeInsets.only(
                                  left: 10, right: 10, top: 5, bottom: 5),
                              height: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('ok'.tr,
                                      style:  const TextStyle(
                                          color: Colors.white, fontSize: 12)),
                                ],
                              ),
                            ),
                          ))
                    ]))
          ])
        ]);
  }
}

showMessageDialog(
    BuildContext context, String title, String message, Icon icon) {
  showDialog(
      useSafeArea: true,
      context: context,
      builder: (_) =>
          MessageDialog(message: message, title: title, icon: icon));
}
