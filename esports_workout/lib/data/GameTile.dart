import 'package:flutter/material.dart';
import '/data/Game.dart';

class GameTile extends StatefulWidget {
  final Game game;
  final VoidCallback onTap;

  const GameTile({Key? key, required this.game, required this.onTap})
      : super(key: key);

  @override
  _GameTileState createState() => _GameTileState();
}

class _GameTileState extends State<GameTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        children: [
          GestureDetector(
            onTap: widget.onTap,
            child: Image.asset(
              widget.game.image,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.game.name,
            style: TextStyle(
              fontSize: 30,
              fontFamily: widget.game.font,
            ),
          ),
        ],
      ),
    );
  }
}
