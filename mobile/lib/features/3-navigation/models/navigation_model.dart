import 'package:flutter/material.dart';

class NavigationModel {
  final int index;
  final IconData icon;
  final IconData iconFill;
  final String title;
  final String titleAppbar;

  NavigationModel({
    required this.index,
    required this.icon,
    required this.iconFill,
    required this.title,
    required this.titleAppbar,
  });
}
