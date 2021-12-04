import 'package:flutter/material.dart';
import 'package:know_your_colleague_flutter/domain/scoreround.dart';
import 'package:know_your_colleague_flutter/pages/dashboard_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class GameFinishedPage extends StatelessWidget {
  const GameFinishedPage(this.score, {Key? key}) : super(key: key);
  final int score;

  @override
  Widget build(BuildContext context) {
    debugPrint('\x1B[32mScore is: $score\x1B[0m');
    return FutureBuilder(
      future: _saveAndGetScore(score),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          List<ScoreRound> scoreRounds = snapshot.data;
          return ListView(
            children: _allScoreRoundsAsWidgets(scoreRounds),
          );
        } else if (snapshot.hasError) {
          return const Center(
              child: Text('Klarte ikke å finne poeng historikk :/'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );

    /*Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(context, SlideRightRoute(page: DashboardPage()), ModalRoute.withName(''));
          },
          child: const Text('Dashboard'),
        ),
      ),
    );
     */
  }
}

List<Widget> _allScoreRoundsAsWidgets(List<ScoreRound> scoreRounds) {
  return scoreRounds
      .map((scoreRound) => ListTile(
            title: Text('${scoreRound.points} - ${scoreRound.date}'),
          ))
      .toList();
}

Future<List<ScoreRound>> _saveAndGetScore(score) async {
  final prefs = await SharedPreferences.getInstance();

  List<ScoreRound> scoresList = [];
  String scoresAsString = prefs.getString('scores') ?? '';
  ScoreRound sr = ScoreRound(getDateAsString(), score);
  if (scoresAsString == '') {
    scoresList.add(sr);
  } else {
    scoresList = ScoreRound.decode(scoresAsString);
    scoresList.add(sr);
  }
  prefs.setString('scores', ScoreRound.encode(scoresList));

  for (var element in scoresList) {
    debugPrint('\x1B[32mScore is: ${element.date} - ${element.points} \x1B[0m');
  }

  scoresList.sort((x, y) => y.points - x.points);
  return scoresList;
}

String getDateAsString() {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  return dateFormat.format(DateTime.now().toLocal());
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const DashboardPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}
