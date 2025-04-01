class WorkoutModel {
  String id;
  String name;
  int duration; // in minutes
  DateTime date;

  WorkoutModel({required this.id, required this.name, required this.duration, required this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'duration': duration,
      'date': date.toIso8601String(),
    };
  }

  factory WorkoutModel.fromMap(Map<String, dynamic> map) {
    return WorkoutModel(
      id: map['id'],
      name: map['name'],
      duration: map['duration'],
      date: DateTime.parse(map['date']),
    );
  }
}
