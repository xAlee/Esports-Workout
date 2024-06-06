import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '/Models/Exercise.dart';
import '/Models/Routine.dart';
import 'SelectExercicesScreen.dart';
import 'package:path_provider/path_provider.dart';

class NewRoutineScreen extends StatefulWidget {
  final List<Exercise> selectedExercises;

  const NewRoutineScreen({super.key, required this.selectedExercises});
  @override
  _NewRoutineScreenState createState() => _NewRoutineScreenState();
}

class _NewRoutineScreenState extends State<NewRoutineScreen> {
  late TextEditingController _titleController;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _titleController.addListener(_updateButtonState);
    // Ensure Flutter bindings are initialized
    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = widget.selectedExercises.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Routine',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(248, 38, 12, 56),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Routine Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: const [
                Icon(
                  Icons.gamepad,
                  color: Color.fromARGB(248, 38, 12, 56),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Start by adding an exercise to your routine',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Acción al presionar el botón "+ Select an Exercise"
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectExerciseScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(248, 38, 12, 56),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text(
                '+ Select an Exercise',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Aquí mostramos los ejercicios seleccionados
            Expanded(
              child: ListView.builder(
                itemCount: widget.selectedExercises.length,
                itemBuilder: (context, index) {
                  final exercise = widget.selectedExercises[index];
                  return ListTile(
                    title: Text(exercise.name),
                    subtitle: Text(exercise.description),
                    trailing: Text('${exercise.repetitions} Reps'),
                  );
                },
              ),
            )
          ],
        ),
      ),
      persistentFooterButtons: [
        ElevatedButton.icon(
          onPressed: _isButtonEnabled
              ? () {
                  // Acción al presionar el botón "Save Routine"
                  _saveRoutineToFile(
                    Routine(
                      title: _titleController.text,
                      exercises: widget.selectedExercises,
                    ),
                  );
                }
              : null,
          icon: const Icon(Icons.save),
          label: const Text('Save Routine'),
        ),
      ],
    );
  }

  Future<void> _saveRoutineToFile(Routine routine) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/routines.json');

    List<Routine> routines = [];
    if (await file.exists()) {
      final data = await file.readAsString();
      final jsonList = json.decode(data) as List<dynamic>;
      routines = jsonList.map((json) => Routine.fromJson(json)).toList();
    }

    routines.add(routine);
    await file
        .writeAsString(json.encode(routines.map((r) => r.toJson()).toList()));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Routine saved successfully!'),
      ),
    );
  }

  Future<List<Routine>> _loadRoutinesFromFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/routines.json');

      if (await file.exists()) {
        final data = await file.readAsString();
        final jsonList = json.decode(data) as List<dynamic>;
        return jsonList.map((json) => Routine.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load routines: $e'),
        ),
      );
      return [];
    }
  }
}
