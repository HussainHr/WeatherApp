import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/config/service/firebase_auth_service.dart';

final firebaseAuthServiceProvider = Provider<FirebaseAuthService>((ref) {
  return FirebaseAuthService();
});

final authStateProvider = StateProvider<User?>((ref) => null);

final isLoggedInProvider = FutureProvider<bool>((ref) async {
  final authServices = ref.read(firebaseAuthServiceProvider);
  return await authServices.isLoggedIn();
});

// store user data if login once a new user
class AuthStateNotifier extends StateNotifier<Map<String, dynamic>?> {
  AuthStateNotifier() : super(null) {
    checkLoginState();
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> checkLoginState() async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      await user.reload();
      user = _firebaseAuth.currentUser;

      state = {
        'name': user?.displayName ?? "Unknown",
        'email': user?.email,
      };
    } else {
      state = null;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    state = null; // Reset state when logged out
  }
}

final isLoggedInProviders =
    StateNotifierProvider<AuthStateNotifier, Map<String, dynamic>?>((ref) {
  return AuthStateNotifier()..checkLoginState();
});
