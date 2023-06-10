import 'package:flutter/material.dart';
import 'package:note_database/Provider/test_provider.dart';
import 'package:note_database/page/checklist_boxArray.dart';
import 'package:provider/provider.dart';

class Others extends StatefulWidget {
  Others({super.key});

  @override
  State<Others> createState() => _OthersState();
}

class _OthersState extends State<Others> {
  TextEditingController typetext = TextEditingController();
  List<String> _Selecteditem = [];

  List<Map<String, dynamic>> valvelistmap = [
    {
      'name': 'Valve 1',
      'time': '08:51',
      'flow': 1,
      'pressure': '2.1',
      'cyclicRst': true,
    },
    {
      'name': 'Valve 2',
      'time': '08:52',
      'flow': 12,
      'pressure': '2.2',
      'cyclicRst': true,
    },
    {
      'name': 'Valve 3',
      'time': '08:53',
      'flow': 123,
      'pressure': '2.3',
      'cyclicRst': true,
    },
    {
      'name': 'Valve 4',
      'time': '08:54',
      'flow': 1234,
      'pressure': '2.4',
      'cyclicRst': true,
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  List<dynamic> getmapvalues(int index) {
    return [
      valvelistmap[index]['time'],
      valvelistmap[index]['flow'],
      valvelistmap[index]['pressure'],
      valvelistmap[index]['cyclicRst'],
    ];
  }

  List<String> getnamevalues(int index) {
    List<String> name = [];
    for (var i = 0; i < valvelistmap.length; i++) {
      if (i != index) {
        name.add(valvelistmap[i]['name'].toString());
      }
    }
    print(name);
    return name;
  }

  void _showMultiSelect(List<String> item) async {
    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelection(items: item);
      },
    );
    // Update UI
    if (results != null) {
      setState(() {
        _Selecteditem = results;
      });
    }
  }

  Widget build(BuildContext context) {
    TestProvider name = Provider.of<TestProvider>(context, listen: true);
    typetext.text = name.name;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Provider Check',
          textAlign: TextAlign.center,
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: valvelistmap.length,
        separatorBuilder: (context, index) => const Divider(
          height: 1,
        ),
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(
              valvelistmap[index]['name'],
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text('details'),
            trailing: IconButton(
                onPressed: () {
                  _showMultiSelect(getnamevalues(index));
                },
                icon: const Icon(Icons.merge)),
            onExpansionChanged: (value) {
              getmapvalues(index);
              print(getmapvalues(index));
            },
            children: <Widget>[
              Column(
                children: [
                  ListTile(
                      title: Text(
                    getmapvalues(index)[0].toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )),
                  ListTile(
                      title: Text(
                    getmapvalues(index)[1].toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )),
                  ListTile(
                      title: Text(
                    getmapvalues(index)[2].toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )),
                  ListTile(
                      title: Text(
                    getmapvalues(index)[2].toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )),
                  ListTile(
                      title: Text(
                    getmapvalues(index)[3].toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
