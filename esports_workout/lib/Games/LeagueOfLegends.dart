import '../data/Game.dart';

class Leagueoflegends extends Game {
  Leagueoflegends()
      : super(
          name: 'League of Legends',
          image: 'assets/games/leagueoflegendsIcon.png',
          font: 'Beaufort for LOL',
        ) {
    ranges.addAll([
      'Unranked',
      'Iron',
      'Bronze',
      'Silver',
      'Gold',
      'Platinum',
      'Emerald',
      'Diamond',
      'Master',
      'Grand Master',
      'Challenger',
    ]);
  }
}
