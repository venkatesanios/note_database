import 'package:flutter/material.dart';
import 'package:note_database/src/Permission.dart';
import 'package:permission_handler/permission_handler.dart';

class Expandpanellis extends StatefulWidget {
  const Expandpanellis({super.key});

  @override
  _ExpandpanellisState createState() => _ExpandpanellisState();
}

class _ExpandpanellisState extends State<Expandpanellis> {
  List<Item> _items = generateItems(5);
  int _expandedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('check')),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: ExpansionPanelList(
            elevation: 1,
            expandedHeaderPadding: EdgeInsets.zero,
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _expandedIndex = isExpanded ? -1 : index;
              });
            },
            children: _items.map<ExpansionPanel>((Item item) {
              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text('Tile ${item.index}'),
                  );
                },
                body: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        PermissionClass permission = PermissionClass();
                        permission.checkPermission(
                            context, Permission.contacts);
                      },
                      child: Text(
                        "Request all Permission",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const ElevatedButton(
                      onPressed: requestMultiplePermission,
                      child: Text(
                        "Request Camera Permission",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const ElevatedButton(
                      onPressed: openAppSettings,
                      child: Text(
                        "Open App Permission",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
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
                          //     key: _formKeytime1[index],
                          child: TextFormField(
                            controller: TextEditingController(
                                text: 'valveModel[index].time'),
                            readOnly: true,
                            onTap: () {
                              // setState(() {
                              //   displayTimeDialog1(
                              //       context, valvelistmap[index]);
                              //   updateValvaModel();
                              // });
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
                          //  key: _formKeyflow[index],
                          child: TextFormField(
                            controller: TextEditingController(
                                text: 'valveModel[index].flow.toString()'),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {},
                            onFieldSubmitted: (value) {
                              // setState(() {
                              //   valvelistmap[index]['flow'] =
                              //       int.tryParse(value) ?? 0;
                              //   updateValvaModel();
                              // });
                            },
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
                          //   key: _formKeypressure[index],
                          child: TextFormField(
                            controller: TextEditingController(
                                text: 'valveModel[index].pressure'),
                            keyboardType: TextInputType.number,
                            onFieldSubmitted: (value) {
                              // setState(() {
                              //   valvelistmap[index]['pressure'] =
                              //       value.toString();
                              //   updateValvaModel();
                              // });
                            },
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
                              // setState(() {
                              //   valvelistmap[index]['cyclicRst'] = isOn;
                              //   updateValvaModel();
                              // });
                            },
                            value: true, //valveModel[index].cyclicRst,
                            activeColor: Colors.white60,
                            activeTrackColor: Colors.green,
                            inactiveThumbColor: Colors.white60,
                            inactiveTrackColor: Colors.red,
                          )),
                    ),
                  ],
                ),
                isExpanded: _expandedIndex == item.index,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

void requestCameraPermission() async {
  // var status = await Permission.camera.status;
  // if (status.isGranted) {
  //   print('Permission Grantedcamera camera');
  // } else if (status.isDenied) {
  //   if (await Permission.camera.request().isGranted) {
  //     print('Permission was granted camera');
  //   }
  // }

  var statusstorage = await Permission.storage.status;
  if (statusstorage.isGranted) {
    print('Permission Granted storage');
  } else if (statusstorage.isDenied) {
    if (await Permission.storage.request().isGranted) {
      print('Permission was granted storage');
    }
  }

  var statusphoto = await Permission.photos.status;
  if (statusphoto.isGranted) {
    print('Permission Granted photos');
  } else if (statusphoto.isDenied) {
    if (await Permission.photos.request().isGranted) {
      print('Permission was granted photos');
    }
  }
}

void requestMultiplePermission() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.location,
    Permission.storage,
    Permission.manageExternalStorage,
    Permission.bluetooth,
    Permission.mediaLibrary
  ].request();
  print("Location Permission: ${statuses[Permission.location]},"
      "storage Permission: ${statuses[Permission.storage]},"
      "camera Permission: ${statuses[Permission.camera]},"
      "bluetooth Permission: ${statuses[Permission.bluetooth]}");
}

void requestPermission() async {
  openAppSettings();
}

class Item {
  Item({required this.index});

  int index;
}

List<Item> generateItems(int count) {
  return List<Item>.generate(count, (int index) {
    return Item(index: index);
  });
}
