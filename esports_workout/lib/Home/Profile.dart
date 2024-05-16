import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white), // Color del texto del título
        ),
        centerTitle: true, // Centra el título en la AppBar
        backgroundColor: const Color.fromARGB(
            248, 38, 12, 56), // Color de fondo de la AppBar
      ),
      body: Container(
        color: Colors.white, // Color de fondo de la página Profile
        child: Center(
          child: Text('Profile Page'),
        ),
      ),
    );
  }
}
