import 'package:esports_workout/Rutines/ClashRoyaleRutine.dart';
import '/ScreenGames/ClashRoyaleLogin.dart';
import 'package:flutter/material.dart';
import '/data/Game.dart';
import '/data/GameTile.dart';
import '/Games/ClashRoyale.dart';
import '/Games/LeagueOfLegends.dart';
import '/Games/Valorant.dart';
import '/Games/Csgo2.dart';
import '/Games/ApexLegends.dart';
import 'package:shared_preferences/shared_preferences.dart';

//En esta pantalla cargamos todos los juegos disponibles, Nuevamente no tienen funciones
//ya que son una demostracion primitiva de como se verian, solo tiene funcionalidad la de
//Clash royale.
class TrainingPage extends StatefulWidget {
  static const String routename = 'trainingPage';
  const TrainingPage({super.key});

  @override
  _TrainingPageState createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Train for a game',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(248, 38, 12, 56),
          automaticallyImplyLeading: false),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: games.length,
              itemBuilder: (BuildContext context, int index) {
                final game = games[index];
                return GameTile(
                  game: game,
                  onTap: () {
                    // Navegar a la pantalla correspondiente al juego seleccionado
                    _navigateToGameScreen(game);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToGameScreen(Game game) async {
    switch (game.name) {
      case 'Clash Royale':
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? profileData = prefs.getString('clashroyale_profile_data');

        if (profileData != null) {
          Navigator.pushNamed(context, Clashroyalerutine.routename);
        } else {
          Navigator.pushNamed(context, Clashroyalelogin.routename);
        }
        break;

      case 'League of Legends':
        //Navigator.pushNamed();
        break;
      case 'Valorant':
        //Navigator.pushNamed();
        break;
      case 'CSGO 2':
        //Navigator.pushNamed();
        break;
      case 'Apex Legends':
        //Navigator.pushNamed();
        break;
      default:
        //No hacer nada si el juego no está definido
        break;
    }
  }
}

final List<Game> games = [
  ClashRoyale(),
  Leagueoflegends(),
  Valorant(),
  ApexLegends(),
  Csgo2(),
];
