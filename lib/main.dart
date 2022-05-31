import 'package:tempo/fireabase.dart';
import 'package:tempo/list_init.dart';
import 'package:tempo/pages/dashboard/dashboard_page.dart';
import 'package:tempo/providers/locale_provider.dart';
import 'package:tempo/providers/transilations.dart';
import 'package:tempo/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tempo/providers_init.dart';

String locale = 'en';
String theme = 'DARK';
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await ProvidersInit.initLT();
  await firebaseInit();
  await initList();
  
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeProvider>(
        create: (BuildContext context) => ThemeProvider(),
      ),
      ChangeNotifierProvider<LocaleProvider>(
        create: (BuildContext context) => LocaleProvider(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: LocaleString(),
      locale: Locale(locale),
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', 'US'), Locale('sw', 'TZ')],
      theme: Provider.of<ThemeProvider>(context).getTheme,
      home:  const DashboardPage( ),
    );
  }
}
