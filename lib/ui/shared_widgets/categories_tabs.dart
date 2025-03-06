import 'package:evently_c13_online/core/theme/app_colors.dart';
import 'package:evently_c13_online/model/category_dm.dart';
import 'package:flutter/material.dart';

class CategoriesTabs extends StatelessWidget {
  final List<CategoryDM> categories;
  final Function(CategoryDM) onCategoryClick;

  const CategoriesTabs(
      {super.key, required this.categories, required this.onCategoryClick});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: TabBar(
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: AppColors.white),
            color: AppColors.white,
          ),
          onTap: (index) {
            onCategoryClick(categories[index]);
          },
          isScrollable: true,
          dividerColor: Colors.transparent,
          unselectedLabelStyle: TextStyle(color: AppColors.white),
          labelStyle: TextStyle(color: AppColors.blue),
          tabs: categories.map(categoryToTab).toList()),
    );
  }

  Tab categoryToTab(CategoryDM category) {
    return Tab(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.white),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              category.icon,
            ),
            Text(category.name),
          ],
        ),
      ),
    );
  }
}
