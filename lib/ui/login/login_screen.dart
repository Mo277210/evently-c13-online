import 'package:evently_c13_online/core/assets/app_assets.dart';
import 'package:evently_c13_online/ui/home_screen/home_screen.dart';
import 'package:evently_c13_online/ui/shared_widgets/language_switch.dart';
import 'package:evently_c13_online/ui/signup_screen/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:icons_plus/icons_plus.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "/loginScreen";

  LoginScreen({super.key});

  late AppLocalizations appLocalizations;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Form(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Image.asset(
                AppAssets.appVerticalLogoImage,
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              TextFormField(
                controller: _emailController,
                style: Theme.of(context).textTheme.bodyLarge,
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  prefixIcon: const Icon(EvaIcons.email),
                  hintText: appLocalizations.email,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                style: Theme.of(context).textTheme.bodyLarge,
                cursorColor: Theme.of(context).primaryColor,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(EvaIcons.lock),
                  suffixIcon: const Icon(EvaIcons.eye),
                  hintText: appLocalizations.password,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      // Handle forgot password
                    },
                    child: Text(appLocalizations.forgetPassword),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () async {
                  await _signInWithEmailAndPassword(context);
                },
                child: Text(appLocalizations.login),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    appLocalizations.dontHaveAccount,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignupScreen.routeName);
                    },
                    child: Text(appLocalizations.signup),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "or",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () async {
                  await _signInWithGoogle(context);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Brand(Brands.google),
                    const SizedBox(width: 8),
                    Text(appLocalizations.googleLogin),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LanguageSwitch(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Successful')),
      );

      // Navigate to the home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      } else {
        errorMessage = 'Login failed. Please try again.';
      }

      // Show the error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );

      // Log the error for debugging
      print("FirebaseAuthException: ${e.code} - ${e.message}");
    } catch (e) {
      // Handle any other unexpected errors
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred. Please try again.')),
      );

      // Log the error for debugging
      print("Unexpected error: $e");
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return; // User canceled login

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Attempt to sign in with Google
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Successful')),
      );

      // Navigate to the home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        // Handle the case where the account already exists with a different credential
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An account already exists with this email. Please sign in with your existing method.')),
        );

        // Optionally, you can prompt the user to sign in with their existing method
        // and then link the Google account.
        // Example:
        // await _handleExistingAccount(context, e.email);
      } else {
        // Handle other Firebase errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Google Sign-In Failed: ${e.message}')),
        );
      }
    } catch (e) {
      // Handle other errors
      print("Google Sign-In Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Google Sign-In Failed. Please try again.')),
      );
    }
  }
}
//https://www.youtube.com/watch?v=hzDDkmqZmVk google login


