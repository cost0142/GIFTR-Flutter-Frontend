import 'package:flutter/material.dart';

class MyTheme {
  MyTheme();

  static ThemeData buildDark() {
    //final base = ThemeData.dark();

    //ThemeData.from( colorScheme: , textTheme: )
    final ThemeData darkBase = ThemeData.from(
      colorScheme: const ColorScheme(
        //base colour scheme that can be overridden for widgets
        primary: Colors.yellow,
        onPrimary: Colors.purple,
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

        background: Colors.indigoAccent,
        onBackground: Color(0xFF003366),
        surface: Colors.lightGreen,
        onSurface: Colors.grey,
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
        ),
        headline2: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.w500,
        ),
        headline3: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.w300,
          fontFamily: 'SendFlowers',
        ),
        headline4: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w300,
        ),
        headline5: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          fontFamily: 'SendFlowers',
        ),
        headline6: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        bodyText1: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w300,
        ),
        bodyText2: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w900,
        ),
        subtitle1: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w300,
        ),
        subtitle2: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w300,
        ),
        button: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ),
    );

    //then build on top of the colorScheme and textTheme
    //to style specific widgets
    ThemeData dark = darkBase.copyWith(
      //colours set in here will override the ColorScheme
      scaffoldBackgroundColor: Color.fromARGB(255, 32, 42, 47),
      shadowColor: Color(0x9900cc66),

      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromRGBO(30, 99, 133, 1),
        foregroundColor: Color.fromARGB(255, 226, 51, 20),
        titleTextStyle: TextStyle(
          fontFamily: 'SendFlowers',
          fontSize: 36,
        ),
        iconTheme: IconThemeData(color: Colors.deepOrange),
        //this will override the iconThemeData
      ),

      iconTheme: const IconThemeData(
        //defaults for icons unless overridden
        color: Colors.orange,
        size: 36,
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.indigo[200],
        foregroundColor: Colors.black54, //for the icon
        elevation: 20, //for all FABs
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              Color.fromARGB(255, 233, 233, 233)),
          foregroundColor: MaterialStateProperty.all<Color>(
              Color.fromARGB(255, 58, 140, 203)),
          elevation: MaterialStateProperty.all(10), //for all ElevatedButtons
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.purple),
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
        tileColor: Colors.amber,
        // textColor: Colors.black, //sets both title and subtitle
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
