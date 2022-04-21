import 'package:flutter/material.dart';

class Theme {

  static ThemeData buildDark = () {
    final ThemeData base = ThemeData.from(
        colorScheme: const ColorScheme(
          //define your base color properties
        ),
        textTheme: const TextTheme(
          //define the text styles for the various types of text
        ),
    );

    //add the style for different widgets
    //uses the base and adds more specific default styles
    final ThemeData dark =  = base.copyWith(
      scaffoldBackgroundColor: Colors.yellow[900],
      appBarTheme: const AppBarTheme(
        //style props
      ),
      // looooooong list of different widgets with their styles
    );

    return dark;
  }
}