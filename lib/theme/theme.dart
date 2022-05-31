import 'package:flutter/material.dart';

//LightTheme
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor:  const Color(0xFFF9FEFF),
  canvasColor:  const Color(0xFFF9F4F4),
  cardColor:  const Color(0xFFFBF5F5),
  // backgroundColor:  const Color(0xFF0071BC),
  backgroundColor:  const Color(0xFFF59E00),

  
  dialogBackgroundColor:   const Color(0xFFE0EEF7),
  cardTheme: lightCardTheme,
  textTheme: lightTextTheme,
  iconTheme: lightIconTheme,
  fontFamily: "Muli",
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
IconThemeData lightIconTheme =  const IconThemeData(
  color:  Color(0xFFF59E00),
);

TextTheme lightTextTheme = TextTheme(
  bodyText1: lightTextWhite,
  bodyText2: lightTextBlack,
  headline1: lightTextWhite,
);
TextStyle lightTextBlack =  const TextStyle(
  fontSize: 12,
  color: Color(0xF0202626),
);
TextStyle lightTextBlackFaint =  const TextStyle(
  fontSize: 12,
  color: Color(0xF0303636),
);
TextStyle lightTextWhite =  const TextStyle(
  fontSize: 12,
  color: Color(0xF0FFFFFF),
);

CardTheme lightCardTheme =  const CardTheme(
    color: Color(0xF0FFFFFF),
    shadowColor: Color(0xF0000000),
);





//DarkTheme
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor:  const Color(0xFF0E1215),
  canvasColor:  const Color(0xFF0E1215),
  cardColor:  const Color(0xFF23272B),
  backgroundColor:  const Color(0xFFF59E00),
  bottomAppBarTheme: darkBottomAppBarTheme,
  bottomAppBarColor:  const Color(0xFF0E1215),
  dialogBackgroundColor:   const Color(0xFF23272B),
  cardTheme: darkCardTheme,
  textTheme: darkTextTheme,
  iconTheme: darkIconTheme,
   fontFamily: "Muli",
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

IconThemeData darkIconTheme =  const IconThemeData(
  color: Color(0xF0FFFFFF),
);
BottomAppBarTheme darkBottomAppBarTheme =  const BottomAppBarTheme(
  color: Color(0xF0FFFFFF),
);
TextTheme darkTextTheme = TextTheme(
  bodyText1: darkTextStyle,
  bodyText2: darkTextStyle2,
);
TextStyle darkTextStyle =  const TextStyle(
  fontSize: 12,
  color: Color(0xF0999F9F),
);
TextStyle darkTextStyle2 =  const TextStyle(
  fontSize: 12,
  color: Color(0xF0FCFCFC),
);

CardTheme darkCardTheme =  const CardTheme(
  color: Color(0xFF23272B),
  shadowColor: Color(0xFFF59E00),
);






