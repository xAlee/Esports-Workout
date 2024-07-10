import 'package:flutter/material.dart';
import 'GameDetailPage.dart';

class GamesPage extends StatelessWidget {
  static const String routeName = 'GamesPage';

  final List<Map<String, dynamic>> games = [
    {
      'name': 'Clash Royale',
      'releaseDate': '2 de marzo de 2016',
      'genre': 'Estrategia',
      'description':
          'Clash Royale es un videojuego de estrategia en tiempo real desarrollado y publicado por Supercell.',
      'website': 'https://clashroyale.com',
      'image': 'assets/games/clashroyaleIcon.png',
      'imdbRating': '6.7',
    },
    {
      'name': 'League of Legends',
      'releaseDate': '27 de octubre de 2009',
      'genre': 'MOBA',
      'description':
          'League of Legends es un videojuego de arena de batalla en línea multijugador desarrollado y publicado por Riot Games.',
      'website': 'https://leagueoflegends.com',
      'image': 'assets/games/leagueoflegendsIcon.png',
      'imdbRating': '7.1',
    },
    {
      'name': 'Valorant',
      'releaseDate': '2 de junio de 2020',
      'genre': 'FPS',
      'description':
          'Valorant es un videojuego de disparos en primera persona desarrollado y publicado por Riot Games.',
      'website': 'https://playvalorant.com',
      'image': 'assets/games/valorantIcon.png',
      'imdbRating': '5.4',
    },
    {
      'name': 'Apex Legends',
      'releaseDate': '4 de febrero de 2019',
      'genre': 'Battle Royale',
      'description':
          'Apex Legends es un videojuego de battle royale desarrollado por Respawn Entertainment y publicado por Electronic Arts.',
      'website': 'https://ea.com/games/apex-legends',
      'image': 'assets/games/apexIcon.png',
      'imdbRating': '7.3',
    },
    {
      'name': 'CSGO 2',
      'releaseDate': '27 de septiembre de 2023',
      'genre': 'FPS',
      'description':
          'Counter-Strike: Global Offensive 2 es la próxima entrega de la popular serie de videojuegos de disparos en primera persona desarrollada por Valve Corporation.',
      'website':
          'https://store.steampowered.com/app/730/CounterStrike_Global_Offensive/',
      'image': 'assets/games/counterstrikeIcon.png',
      'imdbRating': '7.3',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(248, 38, 12, 56),
        title: const Text(
          'Lista de Juegos',
          style: TextStyle(
            color: Colors.white,
            fontSize: 23.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
            color: Colors
                .white), // Cambia el color del botón de retroceso a blanco
      ),
      body: ListView.builder(
        itemCount: games.length,
        itemBuilder: (context, index) {
          final game = games[index];
          return ListTile(
            leading: Image.asset(game['image']!, width: 50, height: 50),
            title: Text(game['name']!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameDetailPage(
                    name: game['name']!,
                    releaseDate: game['releaseDate']!,
                    genre: game['genre']!,
                    description: game['description']!,
                    website: game['website']!,
                    image: game['image']!,
                    imdbRating: game['imdbRating'],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
