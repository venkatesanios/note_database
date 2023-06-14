import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_database/Provider/test_provider.dart';
import 'package:note_database/duplicate/duplicatemodel.dart';
import 'package:note_database/page/checklist_boxArray.dart';
import 'package:note_database/src/displayTimeDialog.dart';
import 'package:provider/provider.dart';

class DuplicatePage extends StatefulWidget {
  const DuplicatePage({Key? key}) : super(key: key);

  @override
  State<DuplicatePage> createState() => _DuplicatePageState();
}

class _DuplicatePageState extends State<DuplicatePage> {
  TextEditingController typetext = TextEditingController();
  List<String> _Selecteditem = [];
  final List<int> _Selecteditemindex = [];
  List<TextEditingController> timeTextControllers =
      []; // Create a list of controllers
  List<TextEditingController> flow_textcontroller = [];
  List<TextEditingController> pressure_textcontroller = [];
  List<bool> cycRst_textcontroller = [];
  bool switch_on_off = false;
  final _formKeytime = GlobalKey<FormState>();
  final _formKeyflow = GlobalKey<FormState>();
  final _formKeypressure = GlobalKey<FormState>();
  late List<DupligateValveSet> valveModel;

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
    updateValvaModel();
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

  Future<void> displayTimeDialog1(
      BuildContext context, Map<String, dynamic> controller) async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (time != null) {
      final formattedTime = DateFormat.Hm().format(DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        time.hour,
        time.minute,
      ));
      setState(() {
        controller['time'] = formattedTime;
        updateValvaModel();
      });
      // = formattedTime;
    }
  }

  void updateValvaModel() {
    valveModel = [];
    for (int i = 0; i < valvelistmap.length; i++) {
      valveModel.add(DupligateValveSet.fromJson(valvelistmap[i]));
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
          int indexva =
              valvelistmap.indexWhere((item) => item["name"] == element);

          Map<String, dynamic> fi = valvelistmap[index];
          valvelistmap[indexva]['time'] = fi['time'];
          valvelistmap[indexva]['flow'] = fi['flow'];
          valvelistmap[indexva]['pressure'] = fi['pressure'];
          valvelistmap[indexva]['cyclicRst'] = fi['cyclicRst'];

          cycRst_textcontroller[indexva] = valvelistmap[indexva]['cyclicRst'];
          timeTextControllers[indexva].text = valvelistmap[indexva]['time'];
          flow_textcontroller[indexva].text =
              valvelistmap[indexva]['flow'].toString();
          pressure_textcontroller[indexva].text =
              valvelistmap[indexva]['pressure'].toString();
        }
        updateValvaModel();
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
        itemCount: valveModel.length,
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
              valveModel[index].name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: const Text('details'),
            trailing: IconButton(
              onPressed: () {
                // setState(() {
                _showMultiSelect(getnamevalues(index), index);
                //  updateValvaModel();
                //  });
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
                          controller: TextEditingController(
                              text: valveModel[index].time),
                          readOnly: true,
                          onTap: () {
                            setState(() {
                              displayTimeDialog1(context, valvelistmap[index]);
                              updateValvaModel();
                            });
                          },
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
                          controller: TextEditingController(
                              text: valveModel[index].flow.toString()),
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
                          controller: TextEditingController(
                              text: valveModel[index].pressure),
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
                              valvelistmap[index]['cyclicRst'] = isOn;
                              updateValvaModel();
                            });
                          },
                          value: valveModel[index].cyclicRst,
                          activeColor: Colors.white60,
                          activeTrackColor: Colors.green,
                          inactiveThumbColor: Colors.white60,
                          inactiveTrackColor: Colors.red,
                          //secondary: switch_on_off ? const Text('On') : const Text('Off'),
                        )),
                  ),
                  // ListTile(
                  //   title: Padding(
                  //     padding: const EdgeInsets.only(
                  //         top: 0, left: 40, right: 40, bottom: 0),
                  //     child: ElevatedButton(
                  //       onPressed: () {
                  //         print(
                  //             'valvelistmap----------------------start---------------------------------------');
                  //         print(valvelistmap);
                  //         setState(() {
                  //           if (_formKeytime.currentState!.validate() &&
                  //               _formKeyflow.currentState!.validate() &&
                  //               _formKeypressure.currentState!.validate()) {
                  //             valvelistmap[index];
                  //             valvelistmap[index]['time'] =
                  //                 timeTextControllers[index].text;
                  //             valvelistmap[index]['flow'] =
                  //                 flow_textcontroller[index].text;
                  //             valvelistmap[index]['pressure'] =
                  //                 pressure_textcontroller[index].text;
                  //             valvelistmap[index]['cyclicRst'] =
                  //                 cycRst_textcontroller[index];
                  //           }

                  //           updateValvaModel();
                  //         });
                  //         print(
                  //             'valvelistmap----------------------end---------------------------------------');
                  //         print(valvelistmap);
                  //       },
                  //       child: const Text('save'),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
