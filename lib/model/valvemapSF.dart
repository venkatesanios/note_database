import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ValveMapSF {
  List<Map<String, dynamic>> valvelistmap = [];

  List<Map<String, dynamic>> valvelistmap1 = [
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

  Future<void> saveListInSharedPreferences(
      List<Map<String, dynamic>> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(list);
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

  Future<List<Map<String, dynamic>>> retrievedshared() async {
    List<Map<String, dynamic>> retrievedList =
        await getListFromSharedPreferences();
    return retrievedList;
  }

  void retrieveSharedData() async {
    valvelistmap = await retrievedshared();

    if (valvelistmap.isEmpty) {
      valvelistmap = valvelistmap1;
    }
    print('valvelistmapif$valvelistmap');
  }

  Future<void> updateValvaModel() async {
    await saveListInSharedPreferences(valvelistmap);
  }
}
