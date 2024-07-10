class Exercise {
  final int id;
  final String name;
  final bool completed;

  Exercise({
    required this.id,
    required this.name,
    this.completed = false, // Por defecto, el ejercicio no está completado
  });

  // Métodos para convertir a mapa y desde mapa
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'completed':
          completed ? 1 : 0, // Convertir bool a entero para SQLite (0 o 1)
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      id: map['id'],
      name: map['name'],
      completed: map['completed'] == 1
          ? true
          : false, // Convertir entero de SQLite a bool
    );
  }
}
