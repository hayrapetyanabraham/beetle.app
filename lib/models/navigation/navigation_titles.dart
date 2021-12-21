import 'package:flutter/material.dart';

class NavigationTitles {
  String? label;
  final Widget icon;
  Widget? activeIcon;

  NavigationTitles({this.activeIcon, required this.icon, this.label});
}
