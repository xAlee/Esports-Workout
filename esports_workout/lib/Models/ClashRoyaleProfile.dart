import 'PlayerProfile.dart';

class ClashRoyaleProfile extends Playerprofile {
  String tag;

  ClashRoyaleProfile(
    this.tag,
    nickName,
    int playerLevel,
    String range,
  ) : super(nickName, playerLevel, range);

  factory ClashRoyaleProfile.fromJson(Map<String, dynamic> json) {
    return ClashRoyaleProfile(json['tag'], json['name'], json['expLevel'],
        json['currentPathOfLegendSeasonResult'].toString());
  }

  Map<String, dynamic> toJson() {
    return {
      'tag': tag,
      'name': nickName,
      'expLevel': playerlevel,
      'currentPathOfLegendSeasonResult' 'leagueNumber': range,
    };
  }
}
