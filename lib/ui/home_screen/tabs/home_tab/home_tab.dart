import 'package:evently_c13_online/core/assets/app_assets.dart';
import 'package:evently_c13_online/core/theme/app_colors.dart';

import 'package:evently_c13_online/model/category_dm.dart';
import 'package:evently_c13_online/model/event_dm.dart';
import 'package:evently_c13_online/model/user_dm.dart';
import 'package:evently_c13_online/ui/home_screen/tabs/home_tab/widget/event_task.dart';

import 'package:flutter/material.dart';

import '../../../../firebase_options.dart';
import '../../../shared_widgets/categories_tabs.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  CategoryDM selectedCategory = CategoryDM.allCategories[0];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
            child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.blue,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(24),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                buildWelcomeText(),
                const SizedBox(
                  height: 5,
                ),
                buildLocationText(),
                CategoriesTabs(
                  categories: CategoryDM.allCategories,
                  onCategoryClick: (category) {
                    selectedCategory = category;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        )),
        buildEventsList()
      ],
    );
  }

  Expanded buildEventsList() {
    return Expanded(
      child: FutureBuilder<List<EventDM>>(
        future: getEventsByCategory(selectedCategory.name),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            print(snapshot.stackTrace);
            return Text("Error");
          } else if (snapshot.hasData) {
            var events = snapshot.data ?? [];
            return ListView.builder(
              itemBuilder: (context, index) => EventTask(
                eventDM: events[index],
              ),
              itemCount: events.length,
            );
          } else {
            return Center(child: const CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Row buildWelcomeText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const Text(
              'Welcome Back ✨',
              style: TextStyle(color: AppColors.white),
            ),
            Text(UserDM.currentUser.name,
                style: const TextStyle(color: AppColors.white)),
          ],
        ),
        const Spacer(),
        const Icon(
          Icons.sunny,
          color: AppColors.white,
          size: 30,
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          alignment: Alignment.center,
          width: 35,
          height: 35,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: AppColors.white),
          child: const Text(
            'EN',
            style:
                TextStyle(color: AppColors.blue, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Row buildLocationText() {
    return const Row(
      children: [
        ImageIcon(
          AssetImage(AppAssets.mapIcon),
          color: AppColors.white,
        ),
        Text('Cairo , Egypt', style: TextStyle(color: AppColors.white)),
      ],
    );
  }
}
