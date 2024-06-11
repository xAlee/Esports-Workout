import 'Exercise.dart';

//Esta clase contiene el estilo de una Rutina, la cual debe tener un titulo y una lista de ejercicios
class Routine {
  final String title;
  final List<Exercise> exercises;

  Routine({
    required this.title,
    required this.exercises,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'exercises': exercises.map((exercise) => exercise.toJson()).toList(),
    };
  }

  factory Routine.fromJson(Map<String, dynamic> json) {
    return Routine(
      title: json['title'],
      exercises: (json['exercises'] as List)
          .map((exerciseJson) => Exercise.fromJson(exerciseJson))
          .toList(),
    );
  }
}
