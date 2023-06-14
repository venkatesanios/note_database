class DupligateValveSet {
  final String name;
  final String time;
  final int flow;
  final String pressure;
  final bool cyclicRst;

  DupligateValveSet({
    required this.name,
    required this.time,
    required this.flow,
    required this.pressure,
    required this.cyclicRst,
  });
  factory DupligateValveSet.fromJson(Map<String, dynamic> json) {
    return DupligateValveSet(
      name: json["name"],
      time: json["time"],
      cyclicRst: json["cyclicRst"],
      flow: json["flow"],
      pressure: json["pressure"],
    );
  }
}
