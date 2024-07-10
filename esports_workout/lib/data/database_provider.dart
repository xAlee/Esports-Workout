import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import '/Models/Routine.dart';
import '/Models/Exercise.dart';

// Lista de rutinas predefinidas
final List<Map<String, dynamic>> predefinedRoutines = [
  {
    'id': 1,
    'gameName': 'Clash Royale',
    'title': 'Routine ClashRoyale',
    'difficulty': 'Easy',
    'exercises': [
      {'id': 1, 'name': 'Exercise 1 for Routine 1'},
      {'id': 2, 'name': 'Exercise 2 for Routine 1'},
    ],
  },
  {
    'id': 2,
    'gameName': 'Clash Royale',
    'title': 'Routine ClashRoyale',
    'difficulty': 'Medium',
    'exercises': [
      {'id': 3, 'name': 'Exercise 1 for Routine 2'},
      {'id': 4, 'name': 'Exercise 2 for Routine 2'},
    ],
  },
  {
    'id': 3,
    'gameName': 'Clash Royale',
    'title': 'Routine ClashRoyale',
    'difficulty': 'Hard',
    'exercises': [
      {'id': 5, 'name': 'Exercise 1 for Routine 3'},
      {'id': 6, 'name': 'Exercise 2 for Routine 3'},
    ],
  },
  {
    'id': 4,
    'gameName': 'League of Legends',
    'title': 'Routine League of Legends',
    'difficulty': 'easy',
    'exercises': [
      {'id': 7, 'name': 'Exercise 1 for Routine 3'},
      {'id': 8, 'name': 'Exercise 2 for Routine 3'},
    ],
  },
  {
    'id': 5,
    'gameName': 'League of Legends',
    'title': 'Routine League of Legends',
    'difficulty': 'Medium',
    'exercises': [
      {'id': 9, 'name': 'Exercise 1 for Routine 3'},
      {'id': 10, 'name': 'Exercise 2 for Routine 3'},
    ],
  },
  {
    'id': 6,
    'gameName': 'League of Legends',
    'title': 'Routine League of Legends',
    'difficulty': 'Hard',
    'exercises': [
      {'id': 11, 'name': 'Exercise 1 for Routine 3'},
      {'id': 12, 'name': 'Exercise 2 for Routine 3'},
    ],
  },
  {
    'id': 7,
    'gameName': 'Valorant',
    'title': 'Routine Valorant',
    'difficulty': 'Easy',
    'exercises': [
      {'id': 13, 'name': 'Exercise 1 for Routine 3'},
      {'id': 14, 'name': 'Exercise 2 for Routine 3'},
    ],
  },
  {
    'id': 8,
    'gameName': 'Valorant',
    'title': 'Routine Valorant',
    'difficulty': 'Medium',
    'exercises': [
      {'id': 15, 'name': 'Exercise 1 for Routine 3'},
      {'id': 16, 'name': 'Exercise 2 for Routine 3'},
    ],
  },
  {
    'id': 9,
    'gameName': 'Valorant',
    'title': 'Routine Valorant',
    'difficulty': 'Hard',
    'exercises': [
      {'id': 17, 'name': 'Exercise 1 for Routine 3'},
      {'id': 18, 'name': 'Exercise 2 for Routine 3'},
    ],
  },
  {
    'id': 10,
    'gameName': 'Apex',
    'title': 'Routine Apex Legends',
    'difficulty': 'Easy',
    'exercises': [
      {'id': 19, 'name': 'Exercise 1 for Routine 3'},
      {'id': 20, 'name': 'Exercise 2 for Routine 3'},
    ],
  },
  {
    'id': 11,
    'gameName': 'Apex',
    'title': 'Routine Apex Legends',
    'difficulty': 'Medium',
    'exercises': [
      {'id': 21, 'name': 'Exercise 1 for Routine 3'},
      {'id': 22, 'name': 'Exercise 2 for Routine 3'},
    ],
  },
  {
    'id': 12,
    'gameName': 'Apex',
    'title': 'Routine Apex Legends',
    'difficulty': 'Hard',
    'exercises': [
      {'id': 23, 'name': 'Exercise 1 for Routine 3'},
      {'id': 24, 'name': 'Exercise 2 for Routine 3'},
    ],
  },
];

// Inicialización de la base de datos y creación de tablas
void initializeDatabase() async {
  try {
    // Abrir la base de datos y crear las tablas si no existen
    final db = await DatabaseProvider.open();

    // Insertar las rutinas predefinidas en la base de datos al inicio de la aplicación
    for (var routineData in predefinedRoutines) {
      Routine routine = Routine(
        id: routineData['id'],
        gameName: routineData['gameName'],
        title: routineData['title'],
        difficulty: routineData['difficulty'],
        exercises: (routineData['exercises'] as List)
            .map((exerciseMap) => Exercise.fromMap(exerciseMap))
            .toList(),
      );

      await DatabaseProvider.saveRoutine(routineData['gameName'], routine);
    }
  } catch (e) {
    print('Error initializing database: $e');
  }
}

class DatabaseProvider {
  static const String dbName = 'games.db';

  static Future<Database> open() async {
    final dbPath = await getDatabasesPath();
    final pathToDb = path.join(dbPath, dbName);

    return openDatabase(
      pathToDb,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE routines(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            gameName TEXT,
            title TEXT,
            difficulty TEXT,
            completed INTEGER DEFAULT 0
          )
        ''');

        await db.execute('''
          CREATE TABLE exercises(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            routineId INTEGER,
            name TEXT,
            completed INTEGER DEFAULT 0,
            FOREIGN KEY(routineId) REFERENCES routines(id)
          )
        ''');
      },
    );
  }

  static Future<void> saveRoutine(String gameName, Routine routine) async {
    final db = await open();
    await db.transaction((txn) async {
      int routineId = await txn.insert('routines', routine.toMap());

      for (Exercise exercise in routine.exercises) {
        await txn.insert('exercises', {
          'routineId': routineId,
          'name': exercise.name,
          'completed': exercise.completed ? 1 : 0,
        });
      }
    });
  }

  static Future<void> updateExerciseStatus(
      int routineId, int exerciseId, bool completed) async {
    final db = await open();
    await db.update(
      'exercises',
      {'completed': completed ? 1 : 0},
      where: 'routineId = ? AND id = ?',
      whereArgs: [routineId, exerciseId],
    );
  }

  static Future<List<Routine>> getClashRoyaleRoutines() async {
    final db = await open();
    final List<Map<String, dynamic>> routinesData = await db.query(
      'routines',
      where: 'gameName = ?',
      whereArgs: ['Clash Royale'],
    );

    print('Routines data: $routinesData');

    List<Routine> routines = [];
    for (var routineData in routinesData) {
      List<Map<String, dynamic>> exercisesData = await db.query(
        'exercises',
        where: 'routineId = ?',
        whereArgs: [routineData['id']],
      );

      print('Exercises data for routine ${routineData['id']}: $exercisesData');

      List<Exercise> exercises = exercisesData
          .map((exerciseData) => Exercise(
                id: exerciseData['id'],
                name: exerciseData['name'],
                completed: exerciseData['completed'] == 1,
              ))
          .toList();

      routines.add(Routine(
        id: routineData['id'],
        gameName: routineData['gameName'],
        title: routineData['title'],
        difficulty: routineData['difficulty'],
        exercises: exercises,
      ));
    }

    return routines;
  }

  static Future<List<bool>> getExerciseStatus(int routineId) async {
    final db = await open();
    final List<Map<String, dynamic>> exercisesData = await db.query(
      'exercises',
      columns: ['completed'],
      where: 'routineId = ?',
      whereArgs: [routineId],
    );

    print('Exercise status data for routine $routineId: $exercisesData');

    return exercisesData
        .map((exerciseData) => exerciseData['completed'] == 1)
        .toList();
  }
}
