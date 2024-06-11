import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '/Models/ClashRoyaleProfile.dart';

//Si las peticiones a la Api de Clash royale fueron ingresadas y correctas, se mostraran aqui.
class ProfilePage extends StatefulWidget {
  static const String routename = 'profilePage';
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ClashRoyaleProfile? profile;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('clashroyale_profile_data');
    if (jsonData != null) {
      Map<String, dynamic> profileMap = jsonDecode(jsonData);
      setState(() {
        profile = ClashRoyaleProfile.fromJson(profileMap);
      });
    }
  }

  Future<void> _signOut(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Borra todos los datos guardados

    // Navega a la pantalla de inicio de sesión y elimina el resto del stack
    Navigator.of(context).pushNamedAndRemoveUntil(
        'StartScreen', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, //Centra el título en la AppBar
        backgroundColor: const Color.fromARGB(248, 38, 12, 56),
        automaticallyImplyLeading: false, //Color de fondo de la AppBar
      ),
      body: Container(
        color: Colors.white, //Color de fondo de la página Profile
        child: Column(
          children: [
            //Menu section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  leading: const Icon(Icons.games, color: Colors.blue),
                  title: const Text('Games Profiles'),
                  onTap: () {
                    _loadProfileData(); // Cargar datos de perfil al presionar el botón
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: profile != null
                  ? Column(
                      children: [
                        Text('Name: ${profile!.nickName}',
                            style: const TextStyle(fontSize: 18)),
                        const SizedBox(height: 10),
                        Text('Tag: ${profile!.tag}',
                            style: const TextStyle(fontSize: 18)),
                        const SizedBox(height: 10),
                        Text('Exp Level: ${profile!.playerlevel}',
                            style: const TextStyle(fontSize: 18)),
                      ],
                    )
                  : const Text('No user data exists',
                      style: TextStyle(fontSize: 18)),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  _signOut(context);
                },
                child: const Text('Sign Out'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
