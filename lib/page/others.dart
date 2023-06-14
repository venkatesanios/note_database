import 'package:flutter/material.dart';
import 'package:note_database/Provider/test_provider.dart';
import 'package:note_database/page/checklist_boxArray.dart';
import 'package:note_database/src/displayTimeDialog.dart';
import 'package:provider/provider.dart';

class Others extends StatefulWidget {
  const Others({Key? key}) : super(key: key);

  @override
  State<Others> createState() => _OthersState();
}

class _OthersState extends State<Others> {
  TextEditingController typetext = TextEditingController();
  List<String> _Selecteditem = [];
  final List<int> _Selecteditemindex = [];
  List<TextEditingController> timeTextControllers =
      []; // Create a list of controllers
  List<TextEditingController> flow_textcontroller = [];
  List<TextEditingController> pressure_textcontroller = [];
  List<bool> cycRst_textcontroller = [];
  final _formKeytime = GlobalKey<FormState>();
  final _formKeyflow = GlobalKey<FormState>();
  final _formKeypressure = GlobalKey<FormState>();

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

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < valvelistmap.length; i++) {
      timeTextControllers.add(TextEditingController());
      flow_textcontroller.add(TextEditingController());
      pressure_textcontroller.add(TextEditingController());
      cycRst_textcontroller.add(valvelistmap[i]['cyclicRst']);

      timeTextControllers[i].text = valvelistmap[i]['time'];
      flow_textcontroller[i].text = valvelistmap[i]['flow'].toString();
      pressure_textcontroller[i].text = valvelistmap[i]['pressure'].toString();
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
    print('first---------------->');
    print(valvelistmap);
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
          int changeindex =
              valvelistmap.indexWhere((item) => item["name"] == element);

          Map<String, dynamic> copyvalve = valvelistmap[index];
          valvelistmap[changeindex]['time'] = copyvalve['time'];
          valvelistmap[changeindex]['flow'] = copyvalve['flow'];
          valvelistmap[changeindex]['pressure'] = copyvalve['pressure'];
          valvelistmap[changeindex]['cyclicRst'] = copyvalve['cyclicRst'];

          cycRst_textcontroller[changeindex] =
              valvelistmap[changeindex]['cyclicRst'];
          timeTextControllers[changeindex].text =
              valvelistmap[changeindex]['time'];
          flow_textcontroller[changeindex].text =
              valvelistmap[changeindex]['flow'].toString();
          pressure_textcontroller[changeindex].text =
              valvelistmap[changeindex]['pressure'].toString();
        }
      });
      print('last---------------->');
      print(valvelistmap);
    }
  }

  @override
  Widget build(BuildContext context) {
    TestProvider name = Provider.of<TestProvider>(context, listen: true);
    List<bool> isExpandedList =
        List.generate(valvelistmap.length, (index) => false);

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
          color: Colors.white30,
        ),
        itemBuilder: (context, index) {
          return ExpansionTile(
            //  collapsedBackgroundColor: Colors.amber,
            backgroundColor: isExpandedList[index]
                ? const Color(0xFF587B2E)
                : const Color.fromARGB(255, 92, 117, 61),
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
                setState(() {
                  _showMultiSelect(getnamevalues(index), index);
                });
              },
              icon: const Icon(Icons.merge),
            ),
            onExpansionChanged: (value) {
              getmapvalues(index);
              setState(() {
                isExpandedList[index] = value;
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
                    trailing: SizedBox(
                      width: 100,
                      child: Form(
                        key: _formKeytime,
                        child: TextFormField(
                          controller: timeTextControllers[index],
                          readOnly: true,
                          onTap: () => displayTimeDialog(
                              context, timeTextControllers[index]),
                          textAlign: TextAlign.center,
                          validator: (title) => title != null && title.isEmpty
                              ? 'The Time cannot be empty'
                              : null,
                        ),
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
                    trailing: SizedBox(
                      width: 100,
                      child: Form(
                        key: _formKeyflow,
                        child: TextFormField(
                          controller: flow_textcontroller[index],
                          keyboardType: TextInputType.number,
                          // onTap: () => displayTimeDialog(
                          //     context, timeTextControllers[index]),
                          textAlign: TextAlign.center,
                          validator: (title) => title != null && title.isEmpty
                              ? 'The Flow cannot be empty'
                              : null,
                        ),
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
                    trailing: SizedBox(
                      width: 100,
                      child: Form(
                        key: _formKeypressure,
                        child: TextFormField(
                          controller: pressure_textcontroller[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          validator: (title) => title != null && title.isEmpty
                              ? 'The Pressure cannot be empty'
                              : null,
                        ),
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
                    trailing: SizedBox(
                        width: 100,
                        child: SwitchListTile(
                          onChanged: (bool isOn) {
                            setState(() {
                              cycRst_textcontroller[index] = isOn;
                            });
                          },
                          value: cycRst_textcontroller[index],
                          activeColor: Colors.white60,
                          activeTrackColor: Colors.green,
                          inactiveThumbColor: Colors.white60,
                          inactiveTrackColor: Colors.red,
                        )),
                  ),
                  ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(
                          top: 0, left: 40, right: 40, bottom: 0),
                      child: ElevatedButton(
                        onPressed: () {
                          print(
                              'valvelistmap----------------------start---------------------------------------');
                          print(valvelistmap);
                          setState(() {
                            if (_formKeytime.currentState!.validate() &&
                                _formKeyflow.currentState!.validate() &&
                                _formKeypressure.currentState!.validate()) {
                              valvelistmap[index];
                              valvelistmap[index]['time'] =
                                  timeTextControllers[index].text;
                              valvelistmap[index]['flow'] =
                                  flow_textcontroller[index].text;
                              valvelistmap[index]['pressure'] =
                                  pressure_textcontroller[index].text;
                              valvelistmap[index]['cyclicRst'] =
                                  cycRst_textcontroller[index];
                            }
                          });
                          print(
                              'valvelistmap----------------------end---------------------------------------');
                          print(valvelistmap);
                        },
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
