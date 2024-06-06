class Exercise {
  final String name;
  final String description;
  final int repetitions;

  Exercise({
    required this.name,
    required this.description,
    required this.repetitions,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'repetitions': repetitions,
    };
  }

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'],
      description: json['description'],
      repetitions: json['repetitions'],
    );
  }
}
