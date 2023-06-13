import 'package:flutter/material.dart';
import 'package:note_database/Provider/test_provider.dart';
import 'package:note_database/page/checklist_boxArray.dart';
import 'package:note_database/src/displayTimeDialog.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Others extends StatefulWidget {
  Others({Key? key}) : super(key: key);

  @override
  State<Others> createState() => _OthersState();
}

class _OthersState extends State<Others> {
  TextEditingController typetext = TextEditingController();
  List<String> _Selecteditem = [];
  List<int> _Selecteditemindex = [];
  List<TextEditingController> timeTextControllers =
      []; // Create a list of controllers
  List<TextEditingController> flow_textcontroller = [];
  List<TextEditingController> pressure_textcontroller = [];
  List<TextEditingController> cyc_textcontroller = [];
  List<bool> cycRst_textcontroller = [];
  bool switch_on_off = false;

  List<Map<String, dynamic>> valvelistmap = [
    {
      'name': 'Valve 1',
      'time': '08:51',
      'flow': 111,
      'pressure': '1.1',
      'cyclicRst': true,
      'index': 0
    },
    {
      'name': 'Valve 2',
      'time': '08:52',
      'flow': 222,
      'pressure': '2.2',
      'cyclicRst': false,
      'index': 1
    },
    {
      'name': 'Valve 3',
      'time': '08:53',
      'flow': 333,
      'pressure': '3.3',
      'cyclicRst': true,
      'index': 2
    },
    {
      'name': 'Valve 4',
      'time': '08:54',
      'flow': 4444,
      'pressure': '4.4',
      'cyclicRst': false,
      'index': 3
    },
  ];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < valvelistmap.length; i++) {
      timeTextControllers.add(TextEditingController());
      flow_textcontroller.add(TextEditingController());
      pressure_textcontroller.add(TextEditingController());
      cyc_textcontroller
          .add(TextEditingController()); // Initialize controllers for each item
    }
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
    List<int> nameindex = [];
    for (var i = 0; i < valvelistmap.length; i++) {
      if (i != index) {
        name.add(valvelistmap[i]['name'].toString());
        nameindex.add(i);
      }
    }
    return name;
  }

  void _showMultiSelect(List<String> item, int index) async {
    print('_showMultiSelect valvelistmap');
    print(valvelistmap);
    final List<String>? results1 = [];
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
        for (var element in _Selecteditem) {
          int indexva =
              valvelistmap.indexWhere((item) => item["name"] == element);

          Map<String, dynamic> fi = valvelistmap[index];
          valvelistmap[indexva]['time'] = fi['time'];
          valvelistmap[indexva]['flow'] = fi['flow'];
          valvelistmap[indexva]['pressure'] = fi['pressure'];
          valvelistmap[indexva]['cyclicRst'] = fi['cyclicRst'];
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TestProvider name = Provider.of<TestProvider>(context, listen: true);
    List<bool> _isExpandedList =
        List.generate(valvelistmap.length, (index) => false);

    typetext.text = name.name;
    String timeval = '';
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
          color: Colors.white30,
        ),
        itemBuilder: (context, index) {
          return ExpansionTile(
            //  collapsedBackgroundColor: Colors.amber,
            backgroundColor: _isExpandedList[index]
                ? Color(0xFF587B2E)
                : Color.fromARGB(255, 92, 117, 61),
            title: Text(
              valvelistmap[index]['name'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: const Text('details'),
            trailing: IconButton(
              onPressed: () {
                _showMultiSelect(getnamevalues(index), index);
              },
              icon: const Icon(Icons.merge),
            ),
            onExpansionChanged: (value) {
              getmapvalues(index);
              setState(() {
                _isExpandedList[index] = value;
              });
            },

            children: <Widget>[
              Column(
                children: [
                  ListTile(
                    title: const Text(
                      'Time',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Container(
                      width: 100,
                      child: TextField(
                        controller: timeTextControllers[index],
                        readOnly: true,
                        onTap: () => displayTimeDialog(
                            context, timeTextControllers[index]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'Flow',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Container(
                      width: 100,
                      child: TextField(
                        controller: flow_textcontroller[index],
                        keyboardType: TextInputType.number,
                        // onTap: () => displayTimeDialog(
                        //     context, timeTextControllers[index]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text('Pressure',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                    trailing: Container(
                      width: 100,
                      child: TextField(
                        controller: pressure_textcontroller[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text('CyclicRST',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                    trailing: Container(
                        width: 100,
                        child: SwitchListTile(
                          onChanged: (bool isOn) {
                            setState(() {
                              switch_on_off = isOn;
                            });
                          },
                          value: switch_on_off,
                          activeColor: Colors.white60,
                          activeTrackColor: Colors.green,
                          inactiveThumbColor: Colors.white60,
                          inactiveTrackColor: Colors.red,
                          secondary: switch_on_off ? Text('On') : Text('Off'),
                        )),
                  ),
                  ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(
                          top: 0, left: 40, right: 40, bottom: 0),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('save'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
