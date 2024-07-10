import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GameDetailPage extends StatelessWidget {
  final String name;
  final String releaseDate;
  final String genre;
  final String description;
  final String website;
  final String image;
  final String imdbRating; // Nuevo campo para la puntuación IMDb

  const GameDetailPage({
    required this.name,
    required this.releaseDate,
    required this.genre,
    required this.description,
    required this.website,
    required this.image,
    required this.imdbRating, // Incluirlo en el constructor
  });

  void _launchURL() async {
    final Uri url = Uri.parse(website);
    if (!await launchUrl(url)) {
      throw 'Could not launch $website';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(248, 38, 12, 56),
        title: Text(
          name,
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
            color: Colors
                .white), // Cambia el color del botón de retroceso a blanco
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(image, width: double.infinity, height: 200),
            const SizedBox(height: 16),
            Text(
              'Fecha de lanzamiento: $releaseDate',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Género: $genre',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Descripción: ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            Text(
              'IMDb Rating: $imdbRating',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _launchURL,
              child: Text('Visitar Página Web'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(248, 38, 12, 56),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
