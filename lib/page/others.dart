import 'package:flutter/material.dart';
import 'package:note_database/Provider/test_provider.dart';
import 'package:provider/provider.dart';

class Others extends StatefulWidget {
  Others({super.key});

  @override
  State<Others> createState() => _OthersState();
}

class _OthersState extends State<Others> {
  TextEditingController typetext = TextEditingController();

  @override
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
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          TextField(
            controller: typetext,
            maxLines: 3,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'text here',
              hintStyle: TextStyle(color: Colors.white60),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
            child: Text('speach'),
            onPressed: () {
              name.namechange(typetext.text);
            },
          ),
        ],
      ),
    );
  }
}
