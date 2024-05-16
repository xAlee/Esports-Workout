import 'package:esports_workout/ScreenGames/ClashRoyaleScreen.dart';
import 'package:flutter/material.dart';
import '/data/Game.dart';
import '/data/GameTile.dart';
import '/Games/ClashRoyale.dart';
import '/Games/LeagueOfLegends.dart';
import '/Games/Valorant.dart';
import '/Games/Csgo2.dart';
import '/Games/ApexLegends.dart';

class TrainingPage extends StatefulWidget {
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
      ),
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

  void _navigateToGameScreen(Game game) {
    switch (game.name) {
      case 'Clash Royale':
        Navigator.pushNamed(context, Clashroyalescreen.routename);
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
        // No hacer nada si el juego no está definido
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
