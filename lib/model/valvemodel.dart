const String tableValves = 'valves';

class ValveFields {
  static final List<String> values = [
    id,
    programid,
    programname,
    valvename,
    time,
    flow,
    pressure,
    cycrst,
  ];

  static const String id = 'id';
  static const String programid = 'programid';
  static const String programname = 'programname';
  static const String valvename = 'valvename';
  static const String time = 'time';
  static const String flow = 'flow';
  static const String pressure = 'pressure';
  static const String cycrst = 'cycrst';
}

class Valve {
  final int? id;
  final int? programid;
  final String programname;
  final String valvename;
  final String time;
  final String flow;
  final String pressure;
  final String cycrst;

  const Valve({
    this.id,
    required this.programid,
    required this.programname,
    required this.valvename,
    required this.time,
    required this.flow,
    required this.pressure,
    required this.cycrst,
  });

  Valve copy({
    int? id,
    int? programid,
    String? programname,
    String? valvename,
    String? time,
    String? flow,
    String? pressure,
    String? cycrst,
  }) =>
      Valve(
        id: id ?? this.id,
        programid: programid ?? this.programid,
        programname: programname ?? this.programname,
        valvename: valvename ?? this.valvename,
        time: time ?? this.time,
        flow: flow ?? this.flow,
        pressure: pressure ?? this.pressure,
        cycrst: cycrst ?? this.cycrst,
      );

  static Valve fromJson(Map<String, Object?> json) => Valve(
        id: json[ValveFields.id] as int?,
        programid: json[ValveFields.programid] as int,
        programname: json[ValveFields.programname] as String,
        valvename: json[ValveFields.valvename] as String,
        time: json[ValveFields.time] as String,
        flow: json[ValveFields.flow] as String,
        pressure: json[ValveFields.pressure] as String,
        cycrst: json[ValveFields.cycrst] as String,
      );

  Map<String, Object?> toJson() => {
        ValveFields.id: id,
        ValveFields.programid: programid,
        ValveFields.programname: programname,
        ValveFields.valvename: valvename,
        ValveFields.time: time,
        ValveFields.flow: flow,
        ValveFields.pressure: pressure,
        ValveFields.cycrst: cycrst,
      };
}
