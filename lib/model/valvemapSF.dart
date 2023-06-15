import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ValveMapSF {
  List<Map<String, dynamic>> valvelistmap = [
    {
      'name': 'Valve 1',
      'time': '08:51',
      'flow': 111,
      'pressure': '1.1',
      'cyclicRst': true,
    },
    {
      'name': 'Valve 2',
      'time': '08:52',
      'flow': 222,
      'pressure': '2.2',
      'cyclicRst': false,
    },
    {
      'name': 'Valve 3',
      'time': '08:53',
      'flow': 333,
      'pressure': '3.3',
      'cyclicRst': true,
    },
    {
      'name': 'Valve 4',
      'time': '08:54',
      'flow': 4444,
      'pressure': '4.4',
      'cyclicRst': false,
    },
  ];

  Future<void> saveListInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(valvelistmap);
    await prefs.setString('valvelistmap', jsonString);
  }

  Future<List<Map<String, dynamic>>> getListFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('valvelistmap');
    if (jsonString != null) {
      List<dynamic> jsonData = jsonDecode(jsonString);
      List<Map<String, dynamic>> list =
          jsonData.map((item) => item as Map<String, dynamic>).toList();
      return list;
    } else {
      return [];
    }
  }

  // Save the list in shared preferences
  void saveshared() {
    saveListInSharedPreferences();
  }

  // Retrieve the list from shared preferences
  Future<List<Map<String, dynamic>>> retrievedshared() async {
    List<Map<String, dynamic>> retrievedList =
        await getListFromSharedPreferences();
    return retrievedList;
  }

  String encode(List<Map<String, dynamic>> data) {
    return json.encode(data);
  }

  List<Map<String, dynamic>> decode(String jsonString) {
    List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((item) => Map<String, dynamic>.from(item)).toList();
  }

  saveval() async {
    List<Map<String, dynamic>> dataList = [
      {'name': 'John', 'age': 25},
      {'name': 'Jane', 'age': 30},
    ];

    String jsonString = encode(dataList);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('dataList', jsonString);

    List<Map<String, dynamic>> dataListq = await retrieveDataList();
  }

  void storeDataList(List<Map<String, dynamic>> dataList) async {
    String jsonString = json.encode(dataList);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('valvelistmap', jsonString);
  }

  Future<List<Map<String, dynamic>>> retrieveDataList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('valvelistmap');
    if (jsonString != null) {
      List<dynamic> jsonData = json.decode(jsonString);
      List<Map<String, dynamic>> decodedList =
          jsonData.map((item) => Map<String, dynamic>.from(item)).toList();
      return decodedList;
    } else {
      return [];
    }
  }
}
