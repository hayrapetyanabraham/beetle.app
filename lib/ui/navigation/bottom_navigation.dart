import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

BottomNavigationBarItem tabItem(String title, String iconPath) {
  return BottomNavigationBarItem(
    icon: SvgPicture.asset(
      iconPath,
    ),
    label: title,
  );
}

class BottomNavigatorProvider with ChangeNotifier {
  int selectedIndex = 0;

  void setSelectedIndex({int selectedBottomOption = 0}) {
    selectedIndex = selectedBottomOption;
    notifyListeners();
  }
}
