import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '/Models/ClashRoyaleProfile.dart';

class Clashroyalelogin extends StatefulWidget {
  static const String routename = 'ClashRoyaleLogin';
  const Clashroyalelogin({super.key});

  @override
  _ClashroyaleloginState createState() => _ClashroyaleloginState();
}

class _ClashroyaleloginState extends State<Clashroyalelogin> {
  String tag = '';
  String nickName = '';
  final token =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6IjRlYjdlN2NmLWJiZTItNGExNy1iYTU5LWE0ZDRjMmU1MmQwYyIsImlhdCI6MTcxNTg2MjcyMCwic3ViIjoiZGV2ZWxvcGVyLzk1MmJhMmI4LTJhYjMtMjA2NC1jNTM0LWRmOWUxYWNiZjgwMCIsInNjb3BlcyI6WyJyb3lhbGUiXSwibGltaXRzIjpbeyJ0aWVyIjoiZGV2ZWxvcGVyL3NpbHZlciIsInR5cGUiOiJ0aHJvdHRsaW5nIn0seyJjaWRycyI6WyIxODEuMTYzLjIwNS41NyJdLCJ0eXBlIjoiY2xpZW50In1dfQ.w25A0GD7jvNv8Io__mkwaf3btevRr_9lLHaL65BL4qkgirfjd_F9ws1Cpx006m51oEW5MzH_IosM2xup3KaZZg'; // Remplaza esto con tu token de API de Clash Royale

  Future<void> getClashRoyalePlayerInfo() async {
    String formattedTag = tag.replaceAll(' ', '');
    formattedTag =
        formattedTag.startsWith('#') ? formattedTag.substring(1) : formattedTag;

    final response = await http.get(
      Uri.parse("https://api.clashroyale.com/v1/players/%23" + formattedTag),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    );

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);

      setState(() {
        nickName = jsonData["name"];
      });

      // Guardar los datos del perfil en el almacenamiento local
      saveProfileData(ClashRoyaleProfile.fromJson(jsonData));
    } else {
      print("Error: ${response.statusCode}");
    }
  }

  Future<void> saveProfileData(ClashRoyaleProfile profile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('clashroyale_profile_data', jsonEncode(profile));
  }

  Future<ClashRoyaleProfile?> loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('clashroyale_profile_data');
    if (jsonData != null) {
      Map<String, dynamic> profileMap = jsonDecode(jsonData);
      return ClashRoyaleProfile.fromJson(profileMap);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Clash Royale Profile',
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
            255, 255, 255, 255), // Color de fondo de la página Training
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<ClashRoyaleProfile?>(
                future: loadProfileData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    ClashRoyaleProfile? profile = snapshot.data;
                    return Column(
                      children: [
                        Text(profile!.tag),
                        Text(profile.nickName),
                        Text(profile.playerlevel.toString()),
                        Text(profile.range),
                      ],
                    );
                  } else {
                    return Text('No data available');
                  }
                },
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    tag = value.replaceAll(' ', '');
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter your tag, for example: VDFA35HGT',
                    border: OutlineInputBorder(),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'\s')),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  getClashRoyalePlayerInfo();
                },
                child: const Text('Join Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
