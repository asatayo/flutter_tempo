import 'package:tempo/builders/language_builder.dart';
import 'package:tempo/duties/update_locale.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class LanguageAlertDialog extends StatefulWidget {
  const LanguageAlertDialog({Key? key}) : super(key: key);
  @override
  LanguageAlertDialogState createState() => LanguageAlertDialogState();
}

class LanguageAlertDialogState extends State<LanguageAlertDialog> {
  bool _isEnglish = true;
  String _selectedLocale = 'sw';

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        insetPadding: const EdgeInsets.all(0),
        backgroundColor: Theme.of(context).cardColor,
        children: [
          FutureBuilder(builder: (context, data) {
            if (data.hasData) {
              _isEnglish = data.data as bool;
            } else {
              _isEnglish = true;
            }
            return Column(children: [
              Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            _selectedLocale = 'en';
                            _isEnglish = true;
                            changeLocale(_selectedLocale, false);
                          });
                        },
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/icons/en.png',
                                      height: 25,
                                      width: 35,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "english".tr,
                                      style: const TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                                _isEnglish
                                    ? const FaIcon(FontAwesomeIcons.check)
                                    : const SizedBox(width: 10),
                              ],
                            )),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _selectedLocale = 'sw';
                            _isEnglish = false;
                            changeLocale(_selectedLocale, false);
                          });
                        },
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/icons/sw.png',
                                      height: 25,
                                      width: 35,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "swahili".tr,
                                      style: const TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                                !_isEnglish
                                    ? const FaIcon(FontAwesomeIcons.check)
                                    : const SizedBox(width: 10),
                              ],
                            )),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              Container(
                // height: 60,
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ButtonTheme(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                              width: 0, color: Colors.transparent),
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0)),
                        ),
                        child: Center(
                          child: Text('cancel'.tr,
                              style: const TextStyle(fontSize: 16)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    ButtonTheme(
                      child: OutlinedButton(
                        onPressed: () {
                          changeLocale(_selectedLocale, true);
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                              width: 0, color: Colors.transparent),
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0)),
                        ),
                        child: Center(
                          child: Text('save'.tr,
                              style: const TextStyle(
                                  color: Colors.green, fontSize: 16)),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ]);
          }, 
          future: loadLanguageBool(),
          )
        ]);
  }
}
    // return SimpleDialog(
    //     insetPadding:  const EdgeInsets.all(0),
    //     backgroundColor: Theme.of(context).cardColor,
    //     children: [
          
    //             Container(
    //                 height: 40,
    //                 padding:  const EdgeInsets.only(
    //                     left: 30, right: 30, top: 5, bottom: 5),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     Expanded(
    //                         flex: 5,
    //                         child: GestureDetector(
    //                           onTap: () {
    //                             Navigator.pop(context);
    //                           },
    //                           child: Center(
    //                             child: Container(
    //                               padding:  const EdgeInsets.only(top: 8),
    //                               child: Text('cancel'.tr),
    //                             ),
    //                           ),
    //                         )),
    //                     Expanded(
    //                         flex: 3,
    //                         child: VerticalDivider(
    //                             width: 1,
    //                             color: Theme.of(context)
    //                                 .textTheme
    //                                 .bodyText2
    //                                 .color)),
    //                     Expanded(
    //                         flex: 5,
    //                         child: GestureDetector(
    //                           onTap: () {
                                
    //                           },
    //                           child: Center(
    //                             child: Container(
    //                               padding:  const EdgeInsets.only(top: 8),
    //                               child: Text('save'.tr),
    //                             ),
    //                           ),
    //                         ))
    //                   ],
    //                 ))
    //           ]);
    //         },
    //         future: loadLanguageBool(),
    //       )
    //     ]);
  

