import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/config/model/user_login_model.dart';
import 'package:weather_app/config/service/auth_service.dart';

//auth service provider
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService('https://dummyjson.com/auth');
});

// //Provider for signup and login operation
// final signUpProvider =
//     FutureProvider.family<Map<String, dynamic>, Map<String, String>>(
//         (ref, credentials) async {
//   final authService = ref.watch(authServiceProvider);
//   final result =
//       await authService.signup(credentials['email']!, credentials['password']!);
//
//   // Store the token
//   ref.read(authTokenProvider.notifier).state = result['token'];
//
//   return result;
// });

final loginProvider =
    FutureProvider.family<UserLoginModel, Map<String, String>>(
        (ref, credentials) async {
  final authService = ref.watch(authServiceProvider);
  final result =
      await authService.login(credentials['username']!, credentials['password']!);

  // Store the token
  ref.read(authTokenProvider.notifier).state = result.token;
  
  return result;
});

//define a provider for authentication token
final authTokenProvider = StateProvider<String?>((ref) => null);

//define a future provider for fetching user details
final userDetailsProvider =
    FutureProvider.family<UserLoginModel, Map<String, String>>(
        (ref, credentials) async {
  final authService = ref.watch(authServiceProvider);
  final token = ref.watch(authTokenProvider);

  if (token == null) {
    throw Exception('User not Authenticated');
  }
  return authService.getUserDetails(token);
});
