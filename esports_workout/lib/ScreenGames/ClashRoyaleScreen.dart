import 'package:esports_workout/Models/PlayerData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Clashroyalescreen extends StatelessWidget {
  static const String routename = 'ClashroyaleScreen';
  const Clashroyalescreen({super.key});

  static String nameTag = ''; // Variable para almacenar el NameTag

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Clash Royale Training',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(248, 38, 12, 56),
      ),
      body: Container(
        color: const Color.fromARGB(
          255,
          182,
          21,
          21,
        ), // Color de fondo de la página Training
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('CR TRAIN'),
              SizedBox(height: 20),
              // Agregar la caja de texto para ingresar el NameTag
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    nameTag = value; // Actualizar el valor de nameTag
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your NameTag',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  getClashRoyalePlayerInfo();
                },
                child: Text('Start Training'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future getClashRoyalePlayerInfo() async {
  final response = await http.get(
    Uri.parse("https://api.clashroyale.com/v1/players/%23" +
        Clashroyalescreen.nameTag),
    headers: headers,
  );

  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print("Error: ${response.statusCode}");
  }
}

var token =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6IjRlYjdlN2NmLWJiZTItNGExNy1iYTU5LWE0ZDRjMmU1MmQwYyIsImlhdCI6MTcxNTg2MjcyMCwic3ViIjoiZGV2ZWxvcGVyLzk1MmJhMmI4LTJhYjMtMjA2NC1jNTM0LWRmOWUxYWNiZjgwMCIsInNjb3BlcyI6WyJyb3lhbGUiXSwibGltaXRzIjpbeyJ0aWVyIjoiZGV2ZWxvcGVyL3NpbHZlciIsInR5cGUiOiJ0aHJvdHRsaW5nIn0seyJjaWRycyI6WyIxODEuMTYzLjIwNS41NyJdLCJ0eXBlIjoiY2xpZW50In1dfQ.w25A0GD7jvNv8Io__mkwaf3btevRr_9lLHaL65BL4qkgirfjd_F9ws1Cpx006m51oEW5MzH_IosM2xup3KaZZg';

var headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ' + token
};
