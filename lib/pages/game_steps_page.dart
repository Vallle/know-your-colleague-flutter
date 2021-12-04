import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:know_your_colleague_flutter/pages/game_finished_page.dart';
import 'package:know_your_colleague_flutter/transitions/slide_transitions.dart';
import 'dashboard_page.dart';
import 'game_pages.dart';

class GameStepsPage extends StatefulWidget {
  const GameStepsPage(this.games, {Key? key}) : super(key: key);

  final List<GameData> games;


  @override
  _GameStepsPageState createState() => new _GameStepsPageState();


}

class _GameStepsPageState extends State<GameStepsPage> {
  late List<GameData> games;
  int score = 0;
  @override
  void initState() {
    this.games = widget.games;
  }

  @override
  Widget build(BuildContext context) {
    if (games.length == 0) {
      return GameFinishedPage(score);
    }
    GameData game =  games.removeLast();
    return Column(
      children: <Widget>[SizedBox(
        height: 260,
        width: 260,
        child: FittedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CachedNetworkImage(imageUrl: game.imageUrl),
          ),
          fit: BoxFit.fill,
        ),
      ), ...game.options.map((e) => Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                if (e.correct) {
                  this.score++;
                }
              });
            },
            child: Text(e.name),
          ),
        ),
      ))],
    );
  }
}