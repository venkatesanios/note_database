import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test App",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  TextEditingController timeinput = TextEditingController();

  String? selectedTime;

  Future<void> displayTimeDialog() async {
    final TimeOfDay? time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time != null) {
      setState(() {
        selectedTime = time.format(context);
        //  selectedTime != null
        //         ? '$selectedTime'
        //         : 'Click Below Button To Select Time...',
        timeinput.text = time.format(context);
      });
    }
  }

  @override
  void initState() {
    timeinput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TimePicker on TextField"),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        height: 150,
        child: Center(
          child: TextField(
            controller: timeinput,
            decoration: const InputDecoration(
              icon: Icon(Icons.timer),
              labelText: "Enter Time",
            ),
            style: TextStyle(fontSize: 20.0, color: Colors.white),
            readOnly: true,
            onTap: displayTimeDialog,
            //onPressed: displayTimeDialog,
          ),
        ),
      ),
    );
  }
}
