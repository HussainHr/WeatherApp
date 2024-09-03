import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/config/model/all_user_list_model.dart';
import 'package:weather_app/config/service/auth_service.dart';

//create this provider for user list
final allUseServiceProvider = Provider<AuthService>((ref) {
  return AuthService('https://dummyjson.com/users');
});

final userListProvider = FutureProvider<AllUserListModel>((ref) async {
  return ref.watch(allUseServiceProvider).getAllUserList();
});
