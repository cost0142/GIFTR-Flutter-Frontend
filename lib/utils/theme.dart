import 'package:flutter/material.dart';

class MyTheme {
  MyTheme();

  static ThemeData buildDark() {
    //final base = ThemeData.dark();

    //ThemeData.from( colorScheme: , textTheme: )
    final ThemeData darkBase = ThemeData.from(
      colorScheme: const ColorScheme(
        //base colour scheme that can be overridden for widgets
        primary: Color.fromARGB(255, 243, 243, 243),
        onPrimary: Colors.black,
        secondary: Colors.blueGrey,
        onSecondary: Colors.lime,
        tertiary: Colors.amber,
        onTertiary: Colors.lime,

        primaryContainer: Colors.white,
        onPrimaryContainer: Colors.black,
        secondaryContainer: Colors.blueAccent,
        onSecondaryContainer: Colors.black,
        tertiaryContainer: Colors.blueAccent,
        onTertiaryContainer: Colors.black,

        background: Color.fromARGB(255, 32, 42, 47),
        onBackground: Colors.white,
        surface: Colors.lightGreen,
        onSurface: Colors.white,
        error: Colors.pink,
        onError: Colors.black87,

        brightness: Brightness.light, // will switch text between dark/light
        //if colorScheme is light the text will be dark
      ),
      textTheme: const TextTheme(
        //base texttheme that can be overridden by widgets
        headline1: TextStyle(
          // letterSpacing: ,
          // fontFamily: ,
          fontSize: 60,
          fontWeight: FontWeight.w700,
          fontFamily: 'SendFlowers',
        ),
        headline2: TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.w500,
          fontFamily: 'SendFlowers',
        ),
        headline3: TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.w300,
          fontFamily: 'SendFlowers',
        ),
        headline4: TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.w300,
          fontFamily: 'SendFlowers',
        ),
        headline5: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w500,
          fontFamily: 'SendFlowers',
        ),
        headline6: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          fontFamily: 'SendFlowers',
        ),
        bodyText1: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w300,
          fontFamily: 'SendFlowers',
        ),
        bodyText2: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          fontFamily: 'SendFlowers',
        ),
        subtitle1: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w500,
          fontFamily: 'SendFlowers',
        ),
        subtitle2: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w300,
          fontFamily: 'SendFlowers',
        ),
        button: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w500,
          fontFamily: 'SendFlowers',
        ),
      ),
    );

    //then build on top of the colorScheme and textTheme
    //to style specific widgets
    ThemeData dark = darkBase.copyWith(
      //colours set in here will override the ColorScheme
      scaffoldBackgroundColor: Color.fromARGB(255, 29, 32, 33),
      shadowColor: Color.fromARGB(153, 76, 174, 192),

      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromRGBO(30, 99, 133, 1),
        foregroundColor: Color.fromARGB(255, 226, 51, 20),
        titleTextStyle: TextStyle(
          fontFamily: 'SendFlowers',
          fontSize: 25,
        ),
        iconTheme: IconThemeData(color: Color.fromRGBO(255, 255, 255, 1)),
        //this will override the iconThemeData
      ),

      iconTheme: const IconThemeData(
        //defaults for icons unless overridden
        color: Colors.orange,
        size: 35,
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color.fromRGBO(30, 99, 133, 1),
        foregroundColor: Colors.white, //for the icon
        elevation: 22, //for all FABs
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Color.fromRGBO(221, 221, 221, 1),
          ),
          foregroundColor:
              MaterialStateProperty.all<Color>(Color.fromARGB(255, 32, 32, 32)),
          elevation: MaterialStateProperty.all(10), //for all ElevatedButtons
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
      ),

      cardTheme: const CardTheme(
        color: Color(0xFF339966), //background of card
        elevation: 12, //shadow distance, z-index for all cards
        //to change the rounding of the corners use shape
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(24),
          ),
        ),
        margin: EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 32.0,
        ),
      ),

      listTileTheme: const ListTileThemeData(
        tileColor: Color.fromARGB(255, 74, 140, 210),
        textColor:
            Color.fromARGB(255, 235, 235, 235), //sets both title and subtitle
        style: ListTileStyle.list,
        //ListTileStyle.list means use subtitle1 for the title
        //ListTileStyle.drawer means use bodyText1 for the title
        dense: false,
        iconColor: Colors.red,
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.amber[200],
        elevation: 16,
        selectedIconTheme: const IconThemeData(color: Colors.red),
        unselectedIconTheme: const IconThemeData(color: Colors.lightBlue),
      ),
    );

    return dark;
  }
}
