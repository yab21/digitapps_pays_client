import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themeKey = 'theme_mode';
  
  ThemeMode _themeMode = ThemeMode.light;
  
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  
  ThemeProvider() {
    _loadTheme();
  }
  
  // Charger le thème sauvegardé
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString(_themeKey);
    
    if (savedTheme != null) {
      _themeMode = savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    }
  }
  
  // Changer de thème
  Future<void> toggleTheme() async {
    _themeMode = _themeMode == ThemeMode.light 
        ? ThemeMode.dark 
        : ThemeMode.light;
    
    await _saveTheme();
    notifyListeners();
  }
  
  // Définir un thème spécifique
  Future<void> setTheme(ThemeMode themeMode) async {
    _themeMode = themeMode;
    await _saveTheme();
    notifyListeners();
  }
  
  // Sauvegarder le thème
  Future<void> _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, _themeMode == ThemeMode.dark ? 'dark' : 'light');
  }
}

// Définition des couleurs pour les thèmes
class AppColors {
  // Couleurs principales utilisées dans l'app
  static const Color primaryBlue = Color(0xFF006BA6);
  static const Color secondaryBlue = Color(0xFF004A7C);
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color darkSuccessGreen = Color(0xFF45A049);
  
  // Couleurs pour le thème clair
  static const Color lightPrimary = primaryBlue;
  static const Color lightSecondary = secondaryBlue;
  static const Color lightSuccess = successGreen;
  static const Color lightBackground = Color(0xFFF8F9FA);
  static const Color lightSurface = Colors.white;
  static const Color lightCardShadow = Color(0x1A000000);
  static const Color lightDivider = Color(0xFFE0E0E0);
  static const Color lightTextPrimary = Colors.black87;
  static const Color lightTextSecondary = Color(0xFF666666);
  
  // Couleurs pour le thème sombre
  static const Color darkPrimary = Color(0xFF0288D1);
  static const Color darkSecondary = Color(0xFF0277BD);
  static const Color darkSuccess = Color(0xFF66BB6A);
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkCardShadow = Color(0x33000000);
  static const Color darkDivider = Color(0xFF424242);
  static const Color darkTextPrimary = Colors.white;
  static const Color darkTextSecondary = Colors.white70;
  
  // Gradients
  static const List<Color> lightGradient = [
    primaryBlue,
    secondaryBlue,
  ];
  
  static const List<Color> darkGradient = [
    darkPrimary,
    darkSecondary,
  ];
  
  // Gradient pour les boutons success
  static const List<Color> lightSuccessGradient = [
    successGreen,
    darkSuccessGreen,
  ];
  
  static const List<Color> darkSuccessGradient = [
    darkSuccess,
    Color(0xFF4CAF50),
  ];
}