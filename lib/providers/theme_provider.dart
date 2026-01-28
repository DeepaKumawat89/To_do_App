// import 'package:flutter/material.dart';
//
// class ThemeProvider extends ChangeNotifier {
//   bool _isDark = false;
//
//
//   bool get isDarkMode => _isDark;
//
//   ThemeMode get themeMode =>
//       _isDark ? ThemeMode.dark : ThemeMode.light;
//
//   void toggleTheme() {
//     _isDark = !_isDark;
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeProvider() {
    _loadTheme();
  }

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode {
    if (_themeMode == ThemeMode.system) {
      return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }

  /// Set theme mode manually (Light, Dark, System)
  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', mode.index);
  }

  /// Toggle light/dark quickly
  Future<void> toggleTheme() async {
    if (_themeMode == ThemeMode.light) {
      await setThemeMode(ThemeMode.dark);
    } else {
      await setThemeMode(ThemeMode.light);
    }
  }

  /// Load theme from SharedPreferences
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    int? index = prefs.getInt('themeMode');
    if (index != null) {
      _themeMode = ThemeMode.values[index];
      notifyListeners();
    }
  }
}
