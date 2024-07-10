import 'Exercise.dart';

class Routine {
  final int id; // Identificador único de la rutina en la base de datos
  final String gameName; // Nombre del juego al que pertenece la rutina
  final String title; // Título de la rutina
  final String difficulty; // Nivel de dificultad de la rutina
  final List<Exercise> exercises; // Lista de ejercicios en la rutina

  Routine({
    required this.id,
    required this.gameName,
    required this.title,
    required this.difficulty,
    required this.exercises,
  });

  // Métodos para convertir una rutina a y desde un mapa (para almacenamiento en la base de datos)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'gameName': gameName,
      'title': title,
      'difficulty': difficulty,
      'exercises': exercises.map((exercise) => exercise.toMap()).toList(),
    };
  }

  factory Routine.fromMap(Map<String, dynamic> map) {
    return Routine(
      id: map['id'],
      gameName: map['gameName'],
      title: map['title'],
      difficulty: map['difficulty'],
      exercises: (map['exercises'] as List)
          .map((exerciseMap) => Exercise.fromMap(exerciseMap))
          .toList(),
    );
  }
}
