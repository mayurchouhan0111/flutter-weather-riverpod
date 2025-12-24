import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final Color _primaryColor = Colors.blue.shade300;
  static const Color _backgroundColor = Color(0xFF1a1a2e);
  static const Color _cardColor = Color(0xFF16213e);
  static const Color _textColor = Colors.white;

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: _primaryColor,
      scaffoldBackgroundColor: Colors.transparent,
      cardColor: _cardColor,
      textTheme: GoogleFonts.montserratTextTheme().apply(
        bodyColor: _textColor,
        displayColor: _textColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _cardColor,
        hintStyle: TextStyle(color: _textColor.withOpacity(0.5)),
        labelStyle: const TextStyle(color: _textColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: _primaryColor),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ).copyWith(
        secondary: _primaryColor,
      ),
    );
  }
}
