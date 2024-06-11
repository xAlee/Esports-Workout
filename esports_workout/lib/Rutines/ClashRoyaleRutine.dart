import 'package:flutter/material.dart';
import 'NewRoutine.dart';

class Clashroyalerutine extends StatelessWidget {
  static const String routename = 'ClashRoyaleRutine';
  const Clashroyalerutine({super.key});

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                // Acción al presionar el botón "New Routine"
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewRoutineScreen(
                      selectedExercises: [],
                    ),
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
                'New Routine',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
