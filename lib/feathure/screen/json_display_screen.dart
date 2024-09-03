import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/config/app_constant/app_constant_file.dart';

import '../../config/model/android_verson_model.dart';

class JsonDataDisplayScreen extends StatefulWidget {
  const JsonDataDisplayScreen({Key? key}) : super(key: key);

  @override
  State<JsonDataDisplayScreen> createState() => _JsonDataDisplayScreenState();
}

class _JsonDataDisplayScreenState extends State<JsonDataDisplayScreen> {
  List<AndroidVersion> androidVersion = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Android Version Data'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      androidVersion = encodeJson(userListOne);
                    });
                   
                  },
                  child: Text('Parse String 1'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      androidVersion = encodeJson(userListTwo);
                    });
                   
                  },
                  child: Text('Parse String 2'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: androidVersion.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(androidVersion[index].title ?? ''),
                  subtitle:
                      Text("ID: ${androidVersion[index].id.toString() ?? ''}"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
