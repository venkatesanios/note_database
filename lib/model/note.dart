const String tableNotes = 'notes';
const String tableValves = 'valves';

class ProgramFields {
  static final List<String> values = [
    /// Add all fields
    id, isImportant, number, title, description, time, setting1, setting2,
    setting3
  ];

  static const String id = '_id';
  static const String isImportant = 'isImportant';
  static const String number = 'number';
  static const String title = 'title';
  static const String description = 'description';
  static const String time = 'time';
  static const String setting1 = 'setting1';
  static const String setting2 = 'setting2';
  static const String setting3 = 'setting3';
}

class Program {
  final int? id;
  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final DateTime createdTime;
  final String setting1;
  final String setting2;
  final String setting3;

  const Program({
    this.id,
    required this.isImportant,
    required this.number,
    required this.title,
    required this.description,
    required this.createdTime,
    required this.setting1,
    required this.setting2,
    required this.setting3,
  });

  Program copy({
    int? id,
    bool? isImportant,
    int? number,
    String? title,
    String? description,
    DateTime? createdTime,
    String? setting1,
    String? setting2,
    String? setting3,
  }) =>
      Program(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        number: number ?? this.number,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
        setting1: setting1 ?? this.setting1,
        setting2: setting2 ?? this.setting2,
        setting3: setting3 ?? this.setting3,
      );

  static Program fromJson(Map<String, Object?> json) => Program(
        id: json[ProgramFields.id] as int?,
        isImportant: json[ProgramFields.isImportant] == 1,
        number: json[ProgramFields.number] as int,
        title: json[ProgramFields.title] as String,
        description: json[ProgramFields.description] as String,
        createdTime: DateTime.parse(json[ProgramFields.time] as String),
        setting1: json[ProgramFields.setting1] as String,
        setting2: json[ProgramFields.setting2] as String,
        setting3: json[ProgramFields.setting3] as String,
      );

  Map<String, Object?> toJson() => {
        ProgramFields.id: id,
        ProgramFields.title: title,
        ProgramFields.isImportant: isImportant ? 1 : 0,
        ProgramFields.number: number,
        ProgramFields.description: description,
        ProgramFields.time: createdTime.toIso8601String(),
        ProgramFields.setting1: setting1,
        ProgramFields.setting2: setting2,
        ProgramFields.setting3: setting3,
      };
}
