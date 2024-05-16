import '../data/Game.dart';

class Valorant extends Game {
  Valorant()
      : super(
          name: 'Valorant',
          image: 'assets/games/valorantIcon.png',
          font: 'Valorant Font',
        ) {
    ranges.addAll([
      'Unranked',
      'Iron',
      'Bronze',
      'Silver',
      'Gold',
      'Platinum',
      'Diamond',
      'Ascendant',
      'Immortal',
      'Radiant',
    ]);
  }
}
