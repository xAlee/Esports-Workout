import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Sign_up.dart';
import '/Home/HomePage.dart';

class StartScreen extends StatelessWidget {
  static const String routename = 'StartScreen';
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              //Primero cargamos el logo y luego una imagen hecha por mi
              Image.asset('assets/icons/logo.jpg'),
              Image.asset('assets/icons/background_login.png'),
              const SizedBox(height: 100), //un espacio de 100 pixeles
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    backgroundColor: const Color.fromARGB(248, 129, 17, 204),
                  ),
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final name = prefs.getString('name');
                    if (name == null) {
                      Navigator.pushNamed(context, SignUp.routename);
                    } else {
                      Navigator.pushNamed(context, Homepage.routename);
                    }
                  },
                  icon: const Icon(
                    Icons.login,
                    color: Colors.white,
                    size: 30,
                  ),
                  label: const Text(
                    'Log in',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    backgroundColor: const Color.fromARGB(248, 38, 12, 56),
                  ),
                  onPressed: () async {
                    Navigator.pushNamed(context, SignUp.routename);
                  },
                  icon: const Icon(
                    Icons.person_add,
                    color: Colors.white,
                    size: 30,
                  ),
                  label: const Text(
                    'Sign up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    backgroundColor: const Color.fromARGB(248, 38, 12, 56),
                  ),
                  //Con el boton de Trash user podemos eliminar los datos, esto es un sistema arcaico ya
                  //que no estoy utilizando bases de datos o conexiones con Google por ejemplo.
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.remove('name');
                    prefs.remove('email');
                    prefs.remove('password');
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 30,
                  ),
                  label: const Text(
                    'User',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
