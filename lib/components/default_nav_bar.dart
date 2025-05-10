import 'dart:io';

import 'package:bookly_app/constants/app_colors.dart';
import 'package:bookly_app/model/nav_bar_model.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class DefaultNavBar extends StatelessWidget {
  final List<BottomNavBarData> navItems;

  final List<Widget> screens;
  final ValueChanged<int> onItemSelected;

  const DefaultNavBar({
    required this.navItems,
    required this.screens,
    required this.onItemSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Platform.isIOS ? 20 : 5),
      child: PersistentTabView(
        context,
        screens: screens,
        items: navItems
            .map(
              (item) => PersistentBottomNavBarItem(
                activeColorSecondary: Colors.white,
                icon: Icon(
                  item.icon,
                  size: 24,
                ),
                title: item.title,
                textStyle: Theme.of(context).textTheme.bodyLarge,
                inactiveColorSecondary: AppColors.primary,
                activeColorPrimary: AppColors.primary,
                inactiveColorPrimary: Colors.grey,
              ),
            )
            .toList(),
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(30.0),
          colorBehindNavBar: Colors.white,
        ),
        navBarStyle: NavBarStyle.style7,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        onItemSelected: onItemSelected,
      ),
    );
  }
}
