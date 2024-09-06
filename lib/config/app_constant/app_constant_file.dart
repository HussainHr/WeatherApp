import 'dart:convert';

import '../model/android_verson_model.dart';

const String userListOne = '[{"0":{"id":1,"title":"Gingerbread"},"1":{"id":2,"title":"Jellybean"},"3":{"id":3,"title":"KitKat"}},[{"id":4,"title":"Lollipop"},{"id":5,"title":"Pie"},{"id":6,"title":"Oreo"},{"id":7,"title":"Nougat"}]]';
const String userListTwo = '[{"0":{"id":1,"title":"Gingerbread"},"1":{"id":2,"title":"Jellybean"},"3":{"id":3,"title":"KitKat"}},{"0":{"id":8,"title":"Froyo"},"2":{"id":9,"title":"Éclair"},"3":{"id":10,"title":"Donut"}},[{"id":4,"title":"Lollipop"},{"id":5,"title":"Pie"},{"id":6,"title":"Oreo"},{"id":7,"title":"Nougat"}]]';

List<AndroidVersion> encodeJson(String jsonStr){
  final parsed = jsonDecode(jsonStr);
  List<AndroidVersion> andoidVersion = [];
  
  for (var item in parsed){
    if(item is Map){
      item.values.forEach((element) {
        andoidVersion.add(AndroidVersion(id: element['id'],
        title: element['title'],));   
      });
    }else if(item is List){
      item.forEach((element) { 
        andoidVersion.add(AndroidVersion(id: element['id'], title: element['title']));
      });
    }
  }
  return andoidVersion;
}

// List<AndroidVersion>  manualJosnEncode(String jsonString ){
//   final parsed = jsonDecode(jsonString);
//   List<AndroidVersion> userList = [];
//  
//   for(var items in parsed){
//     if(items is Map){
//       for (var element in items.values) { 
//         userList.add(AndroidVersion(id: element['id'],title: element['title']));
//       }
//     }else if(items is List){
//       for (var element in items) { 
//         userList.add(AndroidVersion(id: element['id'],title: element['title']));
//       }
//     }
//   }
//   return userList;
// }