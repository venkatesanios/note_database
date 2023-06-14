import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Test App",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
        title: const Text("TimePicker on TextField"),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        height: 150,
        child: Center(
          child: TextField(
            controller: timeinput,
            decoration: const InputDecoration(
              icon: Icon(Icons.timer),
              labelText: "Enter Time",
            ),
            style: const TextStyle(fontSize: 20.0, color: Colors.white),
            readOnly: true,
            onTap: displayTimeDialog,
            //onPressed: displayTimeDialog,
          ),
        ),
      ),
    );
  }
}
