import 'package:tempo/providers/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:provider/provider.dart';

class LaguageWidget extends StatefulWidget {
  final bool isEnglish;
   const LaguageWidget({Key? key,  required this.isEnglish}) : super(key: key);

  @override
  LaguageWidgeState createState() => LaguageWidgeState();
}

class LaguageWidgeState extends State<LaguageWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
            padding:  const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('language_description'.tr,
                    style:  const TextStyle(fontSize: 12)),
                 const SizedBox(
                  height: 10,
                ),
                Divider(height: 1, color: Theme.of(context).backgroundColor),
                 const SizedBox(
                  height: 10,
                ),
                Container(
                  padding:  const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius:  const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              Provider.of<LocaleProvider>(
                                context,
                                listen: false,
                              ).changeLocale('en');
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: widget.isEnglish
                                  ? Theme.of(context).backgroundColor
                                  : Colors.grey,
                              borderRadius:  const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)),
                            ),
                            padding:  const EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 5),
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('english'.tr,
                                    style:  const TextStyle(
                                        color: Colors.white, fontSize: 12)),
                                 const SizedBox(width: 10),
                                widget.isEnglish
                                    ?  const Icon(
                                        FontAwesomeIcons.check,
                                        color: Colors.white,
                                        size: 18,
                                      )
                                    :  const SizedBox(height: 18, width: 18),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              Provider.of<LocaleProvider>(
                                context,
                                listen: false,
                              ).changeLocale('sw');
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: widget.isEnglish
                                  ? Colors.grey
                                  : Theme.of(context).backgroundColor,
                              borderRadius:  const BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                            ),
                            padding:  const EdgeInsets.only(
                                left: 20, right: 20, top: 5, bottom: 5),
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('swahili'.tr,
                                    style:  const TextStyle(
                                        color: Colors.white, fontSize: 12)),
                                 const SizedBox(width: 10),
                                widget.isEnglish
                                    ?  const SizedBox(height: 18, width: 18)
                                    :  const FaIcon(
                                        FontAwesomeIcons.check,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )));
  }
}
