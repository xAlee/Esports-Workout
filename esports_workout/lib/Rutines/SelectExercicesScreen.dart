import 'package:flutter/material.dart';
import 'dart:convert'; //Importa para manejar JSON
import '/Models/Exercise.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'NewRoutine.dart';

class SelectExerciseScreen extends StatefulWidget {
  const SelectExerciseScreen({super.key});

  @override
  _SelectExerciseScreenState createState() => _SelectExerciseScreenState();
}

class _SelectExerciseScreenState extends State<SelectExerciseScreen> {
  List<Exercise> selectedExercises = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Exercise',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(248, 38, 12, 56),
      ),
      body: FutureBuilder<List<Exercise>>(
        future: _loadExercisesFromJson(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final exercises = snapshot.data!;
            return ListView.builder(
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                final exercise = exercises[index];
                final isExerciseSelected = selectedExercises.contains(exercise);

                return ListTile(
                  title: Text(exercise.name),
                  subtitle: Text(exercise.description),
                  onTap: () {
                    setState(() {
                      if (isExerciseSelected) {
                        selectedExercises.remove(exercise);
                      } else {
                        selectedExercises.add(exercise);
                      }
                    });
                  },
                  //Cambiar el icono del botón dependiendo si el ejercicio está seleccionado o no
                  trailing: isExerciseSelected
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : const Icon(Icons.add_circle_outline),
                );
              },
            );
          }
        },
      ),
      //Botón para mostrar la lista de ejercicios seleccionados
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Navegar a la pantalla de rutina con los ejercicios seleccionados
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewRoutineScreen(
                selectedExercises: selectedExercises,
              ),
            ),
          );
        },
        child: const Icon(Icons.check),
      ),
    );
  }

  //Método para cargar los ejercicios desde el archivo JSON
  Future<List<Exercise>> _loadExercisesFromJson() async {
    //Cargar el contenido del archivo JSON
    final jsonString =
        await rootBundle.loadString('assets/PreDefined_Exercises.json');

    //Decodificar el JSON y crear una lista de ejercicios
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((item) => Exercise.fromJson(item)).toList();
  }
}
