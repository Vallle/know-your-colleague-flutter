import 'dart:convert';

class ScoreRound {
  final String date;
  final int points;

  ScoreRound(this.date, this.points);

  Map<String, dynamic> toJson() => {
        'date': date,
        'points': points,
      };

  ScoreRound.fromJson(Map<String, dynamic> json)
      : date = json['date'],
        points = json['points'];

  // https://stackoverflow.com/a/61317989/8883030
  static Map<String, dynamic> toMap(ScoreRound scoreRound) => {
        'date': scoreRound.date,
        'points': scoreRound.points,
      };

  static String encode(List<ScoreRound> scoreRounds) => json.encode(
        scoreRounds
            .map<Map<String, dynamic>>(
                (scoreRound) => ScoreRound.toMap(scoreRound))
            .toList(),
      );

  static List<ScoreRound> decode(String scoreRounds) =>
      (json.decode(scoreRounds) as List<dynamic>)
          .map<ScoreRound>((scoreRound) => ScoreRound.fromJson(scoreRound))
          .toList();
}
