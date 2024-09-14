import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/firebase_project/screen/auth_firebase_screen/firebase_login_screen.dart';
import 'package:weather_app/firebase_project/screen/home/firebase_home_screen.dart';
import '../../../config/provider/firebase_auth_provider.dart';

class AuthenticationWrapper extends ConsumerWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listening to the isLoggedInProviders state
    final userState = ref.watch(isLoggedInProviders);

    // Check the login state and display home or login screen accordingly
    return userState == null
        ? const FirebaseLoginScreen() // If no user is logged in, show the login screen
        : const FirebaseHomeScreen(); // Pass to home screen if logged in
  }
}
