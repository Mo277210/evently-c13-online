import 'package:evently_c13_online/core/assets/app_assets.dart';
import 'package:evently_c13_online/core/theme/app_colors.dart';
import 'package:evently_c13_online/ui/add_event/add_event.dart';
import 'package:evently_c13_online/ui/home_screen/tabs/home_tab/home_tab.dart';
import 'package:evently_c13_online/ui/home_screen/tabs/love_tab/love_tab.dart';
import 'package:evently_c13_online/ui/home_screen/tabs/map_tab/map_tab.dart';
import 'package:evently_c13_online/ui/home_screen/tabs/profile_tab/profile_tab.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs = const [
    HomeTab(),
    MapTab(),
    LoveTab(),
    ProfileTab(),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: buildFab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        backgroundColor: Colors.white,
        bottomNavigationBar: buildBottomNavigation(),
        body: tabs[currentIndex]);
  }

  Widget buildBottomNavigation() {
    return BottomAppBar(
      padding: EdgeInsets.zero,
      shape: const CircularNotchedRectangle(),
      notchMargin: 4,
      clipBehavior: Clip.hardEdge,
      child: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        items: [
          const BottomNavigationBarItem(
              activeIcon: ImageIcon(AssetImage(AppAssets.homeActive)),
              backgroundColor: AppColors.blue,
              icon: ImageIcon(AssetImage(AppAssets.homeIcon)),
              label: 'home'),
          BottomNavigationBarItem(
              activeIcon: const ImageIcon(AssetImage(AppAssets.mapActive)),
              backgroundColor: AppColors.blue,
              icon: Container(
                  margin: const EdgeInsets.only(right: 40),
                  child: const ImageIcon(AssetImage(AppAssets.mapIcon))),
              label: 'map'),
          BottomNavigationBarItem(
              activeIcon: const ImageIcon(AssetImage(AppAssets.loveActive)),
              backgroundColor: AppColors.blue,
              icon: Container(
                  margin: const EdgeInsets.only(left: 32),
                  child: const ImageIcon(AssetImage(AppAssets.loveIcon))),
              label: 'love'),
          const BottomNavigationBarItem(
              activeIcon: ImageIcon(AssetImage(AppAssets.profileActive)),
              backgroundColor: AppColors.blue,
              icon: ImageIcon(AssetImage(AppAssets.profileIcon)),
              label: 'profile'),
        ],
      ),
    );
  }

  FloatingActionButton buildFab() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, AddEvent.routeName);
      },
      backgroundColor: AppColors.blue,
      shape: const CircleBorder(
          side: BorderSide(width: 5, color: AppColors.white)),
      child: const Icon(
        Icons.add,
        color: AppColors.white,
        size: 30,
      ),
    );
  }
}
