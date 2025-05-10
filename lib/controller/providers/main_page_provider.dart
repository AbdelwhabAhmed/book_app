import 'package:bookly_app/views/home/home_page.dart';
import 'package:bookly_app/views/profile_page.dart';
import 'package:bookly_app/views/settings/settings_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationNotifier extends ChangeNotifier {
  int currentIndex = 0;
  late List<Widget> screens;

  NavigationNotifier() {
    screens = [
      const HomePage(),
      const HomePage(),
      ProfilePage(),
      const SettingsPage(),
    ];
  }

  void changeScreen(int val) {
    currentIndex = val;
    notifyListeners();
  }

  void clear() {
    currentIndex = 0;
    notifyListeners();
  }
}

final navigationProvider = ChangeNotifierProvider<NavigationNotifier>(
  (ref) => NavigationNotifier(),
);
