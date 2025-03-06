import 'package:flutter/material.dart';
import 'package:evently_c13_online/ui/login/login_screen.dart';
import '../../core/assets/app_assets.dart';
import '../../core/providers/theme_provider.dart';
import '../../core/theme/app_colors.dart';
import 'package:provider/provider.dart'; // Import the provider package

class OnboardingScreens extends StatefulWidget {
  static const String routeName = "/OnboardingScreens";

  const OnboardingScreens({super.key});

  @override
  _OnboardingScreensState createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.background;
    final themeProvider = Provider.of<ThemeProvider>(context); // Get the ThemeProvider

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: [
                  _buildOnboardingScreen(
                    title: "Find Events That Inspire You",
                    description:
                    "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
                    image:  AppAssets.onboarding1Image, // Dark mode image
                  ),
                  _buildOnboardingScreen(
                    title: "Effortless Event Planning",
                    description:
                    "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
                    image: themeProvider.isDark() ? AppAssets.onboarding2DarkImage : AppAssets.onboarding2lightImage, // Dark mode image
                  ),
                  _buildOnboardingScreen(
                    title: "Connect with Friends & Share Moments",
                    description:
                    "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",
                    image: themeProvider.isDark() ? AppAssets.onboarding3DarkImage : AppAssets.onboarding3lightImage, // Dark mode image
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(3, (int index) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? AppColors.blue
                        : backgroundColor,
                    border: Border.all(
                      color: AppColors.blue,
                      width: 1.5,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _currentPage != 0
                    ? IconButton(
                  onPressed: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                  icon: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: themeProvider.isDark() ? AppColors.dartPurple : Colors.white, // Use AppColors.dartPurple in dark mode
                      border: Border.all(
                        color: AppColors.blue,
                        width: 1.5,
                      ),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back,
                        color: AppColors.blue),
                  ),
                )
                    : const SizedBox(width: 48),
                _currentPage == 2
                    ? IconButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, LoginScreen.routeName);
                  },
                  icon: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: themeProvider.isDark() ? AppColors.dartPurple : Colors.white, // Use AppColors.dartPurple in dark mode
                      border: Border.all(
                        color: AppColors.blue,
                        width: 1.5,
                      ),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_forward,
                        color: AppColors.blue),
                  ),
                )
                    : IconButton(
                  onPressed: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                  icon: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: themeProvider.isDark() ? AppColors.dartPurple : Colors.white, // Use AppColors.dartPurple in dark mode
                      border: Border.all(
                        color: AppColors.blue,
                        width: 1.5,
                      ),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_forward,
                        color: AppColors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingScreen(
      {required String title,
        required String description,
        required String image}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          AppAssets.appHorizontalLogoImage,
          height: MediaQuery.of(context).size.height * 0.07,
        ),
        const SizedBox(height: 16),
        Image.asset(image, height: MediaQuery.of(context).size.height * 0.4),
        const SizedBox(height: 16),
        Text(title, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 12),
        Text(description, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}