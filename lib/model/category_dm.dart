import 'package:flutter/material.dart';

class CategoryDM {
  String name;
  IconData icon;
  String image;

  CategoryDM({required this.name, required this.image, required this.icon});

  static CategoryDM allCategory =
      CategoryDM(name: "All", image: "", icon: Icons.compass_calibration);
  static CategoryDM sportsCategory =
      CategoryDM(name: "Sports", image: "", icon: Icons.sports);
  static CategoryDM birthdayCategory =
      CategoryDM(name: "Birthday", image: "", icon: Icons.compass_calibration);
  static CategoryDM bookingClubCategory = CategoryDM(
      name: "Booking club", image: "", icon: Icons.compass_calibration);

  static List<CategoryDM> defaultCategories = [
    sportsCategory,
    birthdayCategory,
    bookingClubCategory,
  ];
  static List<CategoryDM> allCategories = [
    allCategory,
    sportsCategory,
    birthdayCategory,
    bookingClubCategory,
  ];
}
