import '../data/Game.dart';

class ClashRoyale extends Game {
  ClashRoyale()
      : super(
          name: 'Clash Royale',
          image: 'assets/games/clashroyaleIcon.png',
          font: 'You Blockhead',
        ) {
    ranges.addAll([
      'Unranked',
      'Challenger I',
      'Challenger II',
      'Challenger III',
      'Master I',
      'Master II',
      'Master II',
      'Master III',
      'Champion',
      'Grand Champion',
      'Royal Champion',
      'Ultimate Champion'
    ]);
  }
}
