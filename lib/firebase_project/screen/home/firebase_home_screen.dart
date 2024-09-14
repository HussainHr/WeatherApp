import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/config/provider/firebase_auth_provider.dart';
import 'package:weather_app/firebase_project/screen/auth_firebase_screen/firebase_login_screen.dart';

class FirebaseHomeScreen extends ConsumerWidget {
  const FirebaseHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(isLoggedInProviders);
    if (userState == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const FirebaseLoginScreen()));
      });
      return const Scaffold(
        body: Center(child: Text('User not logged in')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(firebaseAuthServiceProvider).logOut();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FirebaseLoginScreen()));
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome, ${userState['name']}',
                style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            Text('Email: ${userState['email']}'),
            // You can omit showing the password for security reasons.
          ],
        ),
      ),
    );
  }
}
