import 'package:flutter/material.dart';

class Trends extends StatelessWidget {
  static const String routename = 'trends';
  const Trends({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Trends',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(248, 38, 12,
            56), // Cambia el color de fondo de la AppBar según tus preferencias
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          //Aqui muestro como se verian guias y rutinas de otros usuarios de una manera muy primitiva y abstracta
          children: [
            CardGuide(
              cardName: 'Guide: How to use Tornado',
              guideText:
                  'The tornado is one of the most versatile cards to activate our kings tower...',
            ),
            CardGuide(
              cardName: 'Guide: How to use Magic Archer',
              guideText:
                  'The magic archer is one of the few cards that allows us to hit the opponent from our side of the arena...',
            ),
            CardGuide(
              cardName: 'Guide: How to use Miner Control',
              guideText:
                  'The controlled miner is one of the most used archetypes in the entire history of the game, it is based on playing...',
            ),
            CardGuide(
              cardName: 'Rutine By Carlos03',
              guideText:
                  'I want to share this routine with people who are interested in more competitive clashroyale...',
            ),
          ],
        ),
      ),
    );
  }
}

class CardGuide extends StatelessWidget {
  final String cardName;
  final String guideText;
  final VoidCallback? onTap;

  const CardGuide({
    required this.cardName,
    required this.guideText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        color: Colors.grey[800], //Color de fondo más oscuro para la tarjeta
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cardName,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, //Color de texto blanco para contrastar
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                guideText,
                style: const TextStyle(
                    fontSize: 16.0,
                    color:
                        Colors.white), //Color de texto blanco para contrastar
              ),
            ],
          ),
        ),
      ),
    );
  }
}
