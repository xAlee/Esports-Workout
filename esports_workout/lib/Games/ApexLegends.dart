import '../data/Game.dart';

class ApexLegends extends Game {
  ApexLegends()
      : super(
          name: 'Apex Legends',
          image: 'assets/games/apexIcon.png',
          font: 'Apex Legends Font',
        ) {
    ranges.addAll([
      'Unranked',
      'Bronze',
      'Silver',
      'Gold',
      'Platinum',
      'Diamond',
      'Master',
      'Apex Predator',
    ]);
  }
}
