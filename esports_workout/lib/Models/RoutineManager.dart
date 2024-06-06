import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'Routine.dart';

class RoutineManager {
  static const _key = 'routines';

  // Método para guardar una rutina
  static Future<void> saveRoutine(Routine routine) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> routines = prefs.getStringList(_key) ?? [];
    routines.add(jsonEncode(routine.toJson()));
    await prefs.setStringList(_key, routines);
  }

  // Método para recuperar todas las rutinas guardadas
  static Future<List<Routine>> getRoutines() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> routines = prefs.getStringList(_key) ?? [];
    return routines.map((json) => Routine.fromJson(jsonDecode(json))).toList();
  }
}
