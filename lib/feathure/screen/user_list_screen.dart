import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/config/provider/all_user_list_provider.dart';

import '../../config/model/all_user_list_model.dart';

class AllUserListScreen extends ConsumerWidget {
  const AllUserListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(userListProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Total Users"),
        centerTitle: true,
      ),
      body: userAsyncValue.when(
          data: (userList) => ListView.builder(
              itemCount: userList.users!.length,
              itemBuilder: (context, index) {
                Users users = userList.users![index];
                
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.network(users.image ?? ""),
                    title: Text("${users.firstName} ${users.lastName}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email: ${users.email}'),
                        Text('Phone: ${users.phone}'),
                        Text('Age: ${users.age}'),
                        Text('Gender: ${users.gender}'),
                        Text('Address: ${users.address?.address}, ${users.address?.city}'),
                      ],
                    ),
                  ),
                
                );
                
              }),
          error: (error,_)=>Center(child: Text("Error $error"),), 
          loading: ()=>const  Center(child: CircularProgressIndicator(),)),
    );
  }
}
