import 'package:tempo/builders/language_builder.dart';
import 'package:tempo/builders/theme_builder.dart';
import 'package:tempo/providers/locale_provider.dart';
import 'package:tempo/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
   const SettingsPage({Key? key}) : super(key: key);
  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  bool isDark = true;
  bool isEnglish = true;

  String themeMode = 'DARK';

  @override
  initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined,
                color: Theme.of(context).textTheme.bodyText2!.color),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('settings'.tr,
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText2!.color)),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: ListView(
          children: [
            _languageSettings(context),
             const SizedBox(height: 20),
            _modeSettings(context)
          ],
        ),
      ),
    );
  }

  Widget _languageSettings(BuildContext context) {
    return FutureBuilder(
        builder: (BuildContext context, data) {
          if (data.hasData) {
            bool isNewEnglish = data.data as bool;
              isEnglish = isNewEnglish;
            return _languageFuture(isEnglish);
          } else {
            return _languageFuture(true);
          }
        },
        future: loadLanguageBool(),
    );
  }

  Widget _languageFuture(isEnglishNew){
    return  Card(
        child: Container(
            padding:  const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('language_description'.tr,
                  style: const TextStyle(
                    fontSize: 14,
                  ),),
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
                              color: isEnglishNew
                                  ? Theme.of(context).backgroundColor
                                  : Colors.grey,
                              borderRadius:  const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)),
                            ),
                            padding:  const EdgeInsets.only(
                                left: 15, right: 15, top: 5, bottom: 5),
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('english'.tr,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),),
                                 const SizedBox(width: 10),
                                isEnglishNew
                                    ?  const Icon(
                                        FontAwesomeIcons.check,
                                        color: Colors.white,
                                        size: 14,
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
                              color: isEnglishNew
                                  ? Colors.grey
                                  : Theme.of(context).backgroundColor,
                              borderRadius:  const BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                            ),
                            padding:  const EdgeInsets.only(
                                left: 15, right: 15, top: 5, bottom: 5),
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('swahili'.tr,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),),
                                 const SizedBox(width: 10),
                                isEnglishNew
                                    ?  const SizedBox(height: 18, width: 16)
                                    :  const FaIcon(
                                        FontAwesomeIcons.check,
                                        color: Colors.white,
                                        size: 14,
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




 Widget _modeSettings(BuildContext context) {
    return FutureBuilder<bool>(
      builder: (BuildContext context, data) {
        if (data.hasData) {
           isDark = data.data!;
        } else {
          isDark= true;
        }
        return _modeFuture(isDark);
      },
      future: loadThemeBool(),
    );
  }

  Widget _modeFuture(isDarKnew) {
    return Card(
      child: Container(
          padding:  const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('settings_description'.tr,
                style: const TextStyle(
                  fontSize: 14,
                ),),
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
                            isDark = false;
                            Provider.of<ThemeProvider>(
                              context,
                              listen: false,
                            ).changeTheme('LIGHT');
                          });
                        },
                        child: Container(
                          decoration:  const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                          ),
                          padding:  const EdgeInsets.only(
                              left: 15, right: 15, top: 5, bottom: 5),
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('light_mode'.tr,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey
                                ),),
                               const SizedBox(width: 10),
                              isDarKnew
                                  ?  const Icon(
                                      FontAwesomeIcons.lightbulb,
                                      color: Colors.black54,
                                      size: 18,
                                    )
                                  :  const Icon(
                                      FontAwesomeIcons.check,
                                      color: Colors.black54,
                                      size: 14,
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () async {
                          setState(() {
                            isDarKnew = true;
                            Provider.of<ThemeProvider>(
                              context,
                              listen: false,
                            ).changeTheme('DARK');
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.9),
                            borderRadius:  const BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                topRight: Radius.circular(10)),
                          ),
                          padding:  const EdgeInsets.only(
                              left: 15, right: 15, top: 5, bottom: 5),
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('dark_mode'.tr,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey,
                              ),
                                      ),
                               const SizedBox(width: 10),
                              isDarKnew
                                  ?  const FaIcon(
                                      FontAwesomeIcons.check,
                                      color: Colors.grey,
                                      size: 16,
                                    )
                                  :  const FaIcon(
                                      FontAwesomeIcons.lightbulb,
                                      color: Colors.grey,
                                      size: 16,
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
          )),
    );
  }
}
