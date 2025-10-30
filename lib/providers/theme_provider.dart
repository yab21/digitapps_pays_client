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
  // Couleurs pour le thème clair
  static const Color lightPrimary = Color(0xFF1565C0);
  static const Color lightSecondary = Color(0xFF1E88E5);
  static const Color lightAccent = Color(0xFF0D47A1);
  static const Color lightBackground = Color(0xFFF8F9FA);
  static const Color lightSurface = Colors.white;
  static const Color lightCardShadow = Color(0x1A000000);
  
  // Couleurs pour le thème sombre
  static const Color darkPrimary = Color(0xFF2196F3);
  static const Color darkSecondary = Color(0xFF64B5F6);
  static const Color darkAccent = Color(0xFF1976D2);
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkCardShadow = Color(0x33000000);
  
  // Gradients
  static const List<Color> lightGradient = [
    Color(0xFF1E88E5),
    Color(0xFF1565C0),
    Color(0xFF0D47A1),
  ];
  
  static const List<Color> darkGradient = [
    Color(0xFF2196F3),
    Color(0xFF1976D2),
    Color(0xFF0D47A1),
  ];
}