import 'package:flutter/material.dart';

class BottomNavBarData {
  final String title;
  final IconData icon;

  const BottomNavBarData({
    required this.title,
    required this.icon,
  });

  static List<BottomNavBarData> get navBarData {
    return [
      BottomNavBarData(
        icon: Icons.home,
        title: 'Home',
      ),
      BottomNavBarData(
        icon: Icons.search,
        title: 'Search',
      ),
      BottomNavBarData(
        icon: Icons.person,
        title: 'Profile',
      ),
    ];
  }
}
