import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:note_database/model/programmodel.dart';
import 'package:note_database/model/valvemodel.dart';
import 'package:note_database/widgets/add_valve_widget.dart';

import '../db/program_database.dart';

class AddEditValvePage extends StatefulWidget {
  final Valve? valve;
  final Program? program;

  const AddEditValvePage({
    Key? key,
    this.valve,
    this.program,
  }) : super(key: key);
  @override
  _AddEditValvePageState createState() => _AddEditValvePageState();
}

class _AddEditValvePageState extends State<AddEditValvePage> {
  final _formKey = GlobalKey<FormState>();
  late int id;
  late int programid;
  late String programname;
  late String valvename;
  late String time;
  late String flow;
  late String pressure;
  late String cycrst;

  @override
  void initState() {
    super.initState();

    id = widget.valve?.id ?? 0;
    programid = widget.program?.id ?? 0;
    programname = widget.program?.title?? '';
    valvename = widget.valve?.valvename ?? '';
    time = widget.valve?.time ?? '';
    flow = widget.valve?.flow ?? '';
    pressure = widget.valve?.pressure ?? '';
    cycrst = widget.valve?.cycrst ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Add/Edit Valve'),
          actions: [buildButton(), deleteButton()],
        ),
        body: Form(
          key: _formKey,
          child: ValveFormWidget(
            id: id,
            programid: programid,
            programname: programname,
            valvename: valvename,
            time: time,
            flow: flow,
            pressure: pressure,
            cycrst: cycrst,
            onChangedNumber: (programid) =>
                setState(() => this.programid = programid),
            onChangedTitle: (valvename) => setState(() => this.valvename = valvename),
            onChangedDescription: (time) => setState(() => this.time = time),
            onChangedSetting1: (flow) => setState(() => this.flow = flow),
            onChangedSetting2: (pressure) =>
                setState(() => this.pressure = pressure),
            onChangedSetting3: (cycrst) => setState(() => this.cycrst = cycrst),
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = valvename.isNotEmpty && programname.isNotEmpty;
log('programname : ' + programname);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: isFormValid ? null : Colors.amber,
        ),
        onPressed: addOrUpdateProgram,
        child: const Text('Save'),
      ),
    );
  }

  void addOrUpdateProgram() async {
    final isValid = _formKey.currentState!.validate();
    print('IsValid$isValid');

    if (isValid) {
      final isUpdating = widget.valve != null;

      if (isUpdating) {
        await updateValve();
      } else {
        await addValve();
      }

      Navigator.of(context).pop();
    }
  }

  Widget deleteButton() => IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          //  await ProgramDatabase.instance.delete(widget.note!.id);

          Navigator.of(context).pop();
        },
      );

  Future updateValve() async {
    final updatevalve = widget.valve!.copy(
        programid: id,
        programname: programname,
        valvename: valvename,
        time: time,
        flow: flow,
        pressure: pressure,
        cycrst: cycrst);

    await ProgramDatabase.instance.updatevalve(updatevalve);
  }

  Future addValve() async {
    final valveadd = Valve(
        programid: programid,
        programname: programname,
        valvename: valvename,
        time: time,
        flow: flow,
        pressure: pressure,
        cycrst: cycrst);
    await ProgramDatabase.instance.createvalve(valveadd);
  }
}
