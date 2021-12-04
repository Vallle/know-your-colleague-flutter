import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'game_pages.dart';

class GameStepsPage extends StatefulWidget {
  const GameStepsPage(this.games, {Key? key}) : super(key: key);

  final List<GameData> games;


  @override
  _GameStepsPageState createState() => new _GameStepsPageState();


}

class _GameStepsPageState extends State<GameStepsPage> {
  late List<GameData> games;

  @override
  void initState() {
    this.games = widget.games;
  }

  @override
  Widget build(BuildContext context) {

    GameData game =  games.removeLast();

    return Column(
      children: <Widget>[SizedBox(
        height: 60,
        width: 60,
        child: FittedBox(
          child: CachedNetworkImage(imageUrl: game.imageUrl),
          fit: BoxFit.fill,
        ),
      )],
    );
  }
}