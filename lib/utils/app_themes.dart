import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/theme_provider.dart';

class AppThemes {
  // Thème clair
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.lightPrimary,
    colorScheme: const ColorScheme.light(
      primary: AppColors.lightPrimary,
      secondary: AppColors.lightSecondary,
      tertiary: AppColors.lightSuccess,
      surface: AppColors.lightSurface,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.lightTextPrimary,
      onTertiary: Colors.white,
    ),
    
    // Extension pour les couleurs personnalisées
    extensions: const [
      CustomColors(
        success: AppColors.lightSuccess,
        successDark: AppColors.darkSuccessGreen,
        divider: AppColors.lightDivider,
        textSecondary: AppColors.lightTextSecondary,
        gradient: AppColors.lightGradient,
        successGradient: AppColors.lightSuccessGradient,
      ),
    ],
    
    // Typographie
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: AppColors.lightTextPrimary,
      displayColor: AppColors.lightTextPrimary,
    ),
    
    // AppBar
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.lightPrimary,
      foregroundColor: Colors.white,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    
    // Boutons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightPrimary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        elevation: 5,
      ),
    ),
    
    // Champs de texte
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppColors.lightPrimary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppColors.lightPrimary, width: 2),
      ),
      filled: true,
      fillColor: AppColors.lightBackground,
      labelStyle: const TextStyle(color: AppColors.lightPrimary),
      prefixIconColor: AppColors.lightPrimary,
    ),
    
    // Bottom Navigation
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.lightSurface,
      selectedItemColor: AppColors.lightPrimary,
      unselectedItemColor: Colors.grey,
      elevation: 10,
    ),
    
    // Card Theme
    cardTheme: CardThemeData(
      color: AppColors.lightSurface,
      elevation: 2,
      shadowColor: AppColors.lightCardShadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    
    // Divider
    dividerTheme: const DividerThemeData(
      color: AppColors.lightDivider,
      thickness: 1,
    ),
    
    // Scaffold
    scaffoldBackgroundColor: AppColors.lightBackground,
  );
  
  // Thème sombre
  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.darkPrimary,
      secondary: AppColors.darkSecondary,
      tertiary: AppColors.darkSuccess,
      surface: AppColors.darkSurface,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.darkTextPrimary,
      onTertiary: Colors.white,
    ),
    
    // Extension pour les couleurs personnalisées
    extensions: const [
      CustomColors(
        success: AppColors.darkSuccess,
        successDark: Color(0xFF4CAF50),
        divider: AppColors.darkDivider,
        textSecondary: AppColors.darkTextSecondary,
        gradient: AppColors.darkGradient,
        successGradient: AppColors.darkSuccessGradient,
      ),
    ],
    
    // Typographie
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: AppColors.darkTextPrimary,
      displayColor: AppColors.darkTextPrimary,
    ),
    
    // AppBar
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.darkSurface,
      foregroundColor: Colors.white,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    
    // Boutons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkPrimary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        elevation: 5,
      ),
    ),
    
    // Champs de texte
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppColors.darkDivider),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppColors.darkDivider),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppColors.darkPrimary, width: 2),
      ),
      filled: true,
      fillColor: AppColors.darkSurface,
      labelStyle: const TextStyle(color: AppColors.darkTextSecondary),
      hintStyle: const TextStyle(color: AppColors.darkTextSecondary),
      prefixIconColor: AppColors.darkPrimary,
    ),
    
    // Bottom Navigation
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkSurface,
      selectedItemColor: AppColors.darkPrimary,
      unselectedItemColor: Colors.grey,
      elevation: 10,
    ),
    
    // Card Theme
    cardTheme: CardThemeData(
      color: AppColors.darkSurface,
      elevation: 2,
      shadowColor: AppColors.darkCardShadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    
    // Divider
    dividerTheme: const DividerThemeData(
      color: AppColors.darkDivider,
      thickness: 1,
    ),
    
    // Scaffold
    scaffoldBackgroundColor: AppColors.darkBackground,
  );
}

// Extension pour les couleurs personnalisées
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  final Color success;
  final Color successDark;
  final Color divider;
  final Color textSecondary;
  final List<Color> gradient;
  final List<Color> successGradient;

  const CustomColors({
    required this.success,
    required this.successDark,
    required this.divider,
    required this.textSecondary,
    required this.gradient,
    required this.successGradient,
  });

  @override
  CustomColors copyWith({
    Color? success,
    Color? successDark,
    Color? divider,
    Color? textSecondary,
    List<Color>? gradient,
    List<Color>? successGradient,
  }) {
    return CustomColors(
      success: success ?? this.success,
      successDark: successDark ?? this.successDark,
      divider: divider ?? this.divider,
      textSecondary: textSecondary ?? this.textSecondary,
      gradient: gradient ?? this.gradient,
      successGradient: successGradient ?? this.successGradient,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      success: Color.lerp(success, other.success, t)!,
      successDark: Color.lerp(successDark, other.successDark, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      gradient: gradient,
      successGradient: successGradient,
    );
  }
}