import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evently_c13_online/core/assets/app_assets.dart';
import 'package:evently_c13_online/core/providers/theme_provider.dart';
import 'package:evently_c13_online/ui/login/login_screen.dart';
import 'package:evently_c13_online/ui/shared_widgets/language_switch.dart';
import 'package:evently_c13_online/ui/shared_widgets/theme_switch.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'onboarding.dart';
class OnboardingSetupScreen extends StatelessWidget {
  static const String routeName = "/OnboardingSetupScreen";

  late ThemeProvider themeProvider;
  late AppLocalizations appLocalizations;
  OnboardingSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                AppAssets.appHorizontalLogoImage,
                height: MediaQuery.of(context).size.height * 0.07,
              ),
              Expanded(
                child: Image.asset(themeProvider.isDark()
                    ? AppAssets.onBoarding1DarkImage
                    : AppAssets.onBoarding1lightImage),
              ),
              const SizedBox(height: 16),
              Text(
                appLocalizations.personalizeYourExperience,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 16),
              Text(
                  appLocalizations.setupScreenDescription,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    appLocalizations.language,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  LanguageSwitch()
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    appLocalizations.theme,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  ThemeSwitch(),
                ],
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, OnboardingScreens.routeName);
                },
                child: Text(appLocalizations.letsStart),
              )
            ],
          ),
        ),
      ),
    );
  }
}
