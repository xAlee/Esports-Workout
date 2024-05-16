import '../data/Game.dart';

class Csgo2 extends Game {
  Csgo2()
      : super(
          name: 'Counter - Strike 2',
          image: 'assets/games/counterstrikeIcon.png',
          font: 'Counter-Strike',
        ) {
    ranges.addAll([
      'Unranked',
      'Silver',
      'Silver II',
      'Silver III',
      'Silver IV',
      'Silver Elite',
      'Silver Elite Master',
      'Gold Nova',
      'Gold Nova II',
      'Gold Nova III',
      'Gold Nova Master',
      'Master Guardian I',
      'Master Guardian II',
      'Master Guardian Elite',
      'Distinguished Master Guardian',
      'Legendary Eagle',
      'Legendary Eagle Master',
      'Supreme Master First Class',
      'Global Elite',
    ]);
  }
}
