import 'package:flutter/material.dart';
import '/Models/Routine.dart'; // Asegúrate de que Routine y Exercise estén importados correctamente
import '/Models/Exercise.dart';
import '/data/database_provider.dart';

class Clashroyalerutine extends StatelessWidget {
  static const String routename = 'ClashRoyaleRutine';
  const Clashroyalerutine({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Training',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(248, 38, 12, 56),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Routine>>(
          future: DatabaseProvider.getClashRoyaleRoutines(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              // Aquí defines tus rutinas predefinidas

              // Combinar las rutinas predefinidas con las obtenidas de la base de datos
              final List<Routine> allRoutines = [
                ...snapshot
                    .data!, // Agregar las rutinas obtenidas de la base de datos
                ...List.generate(predefinedRoutines.length, (index) {
                  final routineData = predefinedRoutines[index];
                  // Convertir la lista de ejercicios desde el mapa
                  List<Exercise> exercises = (routineData['exercises'] as List)
                      .map((exerciseMap) => Exercise.fromMap(exerciseMap))
                      .toList();

                  return Routine(
                    id: routineData['id'],
                    gameName: routineData['gameName'],
                    title: routineData['title'],
                    difficulty: routineData['difficulty'],
                    exercises:
                        exercises, // Asignar la lista de ejercicios convertidos
                  );
                }),
              ];

              return ListView.builder(
                itemCount: allRoutines.length,
                itemBuilder: (context, index) {
                  final routine = allRoutines[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(routine.title),
                      subtitle: Text('Difficulty: ${routine.difficulty}'),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              RoutineDetailScreen(routine: routine),
                        ));
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class RoutineDetailScreen extends StatefulWidget {
  final Routine routine;

  const RoutineDetailScreen({required this.routine});

  @override
  _RoutineDetailScreenState createState() => _RoutineDetailScreenState();
}

class _RoutineDetailScreenState extends State<RoutineDetailScreen> {
  late List<bool> exerciseStatus;

  @override
  void initState() {
    super.initState();
    exerciseStatus = List<bool>.filled(widget.routine.exercises.length, false);
    loadExerciseStatus();
  }

  void loadExerciseStatus() async {
    List<bool> loadedStatus =
        await DatabaseProvider.getExerciseStatus(widget.routine.id);
    if (loadedStatus.isNotEmpty) {
      setState(() {
        exerciseStatus = loadedStatus;
      });
    }
  }

  void saveExerciseStatus(int exerciseIndex, bool completed) {
    DatabaseProvider.updateExerciseStatus(
        widget.routine.id, exerciseIndex, completed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.routine.title),
        backgroundColor: const Color.fromARGB(248, 38, 12, 56),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Difficulty: ${widget.routine.difficulty}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Exercises:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.routine.exercises.length,
              itemBuilder: (context, index) {
                final exercise = widget.routine.exercises[index];
                return CheckboxListTile(
                  title: Text(exercise.name),
                  value: exerciseStatus[index],
                  onChanged: (value) {
                    setState(() {
                      exerciseStatus[index] = value!;
                      saveExerciseStatus(index, value);
                    });
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
