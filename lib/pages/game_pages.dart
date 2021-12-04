import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:know_your_colleague_flutter/domain/colleague.dart';
import 'package:know_your_colleague_flutter/transitions/slide_transitions.dart';
import 'package:http/http.dart' as http;
import 'game_finished_page.dart';
import 'game_steps_page.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: _getGames(1), // TODO : Change this to 10
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return GameStepsPage(snapshot.data);
          } else if (snapshot.hasError) {
            return const Center(child: Text('Funket ikke :('));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<List<GameData>> _getGames(int count) async {
    dynamic response = await _fetchPeople();
    List<dynamic> colleaguesJson = jsonDecode(response.body);


    List<Colleague> colleagues =  colleaguesJson.map((e) => Colleague.fromJson(e)).toList();

    colleagues.shuffle();

    return colleagues.take(count).map((element) =>
      GameData(_getOptions(colleagues, element.name), element.imageUrl)
    ).toList();
  }

  Future<http.Response> _fetchPeople() {
    return http.get(Uri.parse(
        'https://employee-image-provider.azurewebsites.net/api/fetchallemployeeimageurls?code=goLWvtqQUZPhvDSlHEQkVlrH4JJngoZIVdVojOgGSMMJgXIGLzJjBQ=='));
  }

  List<PersonOption> _getOptions(List<Colleague> colleagues,String correctName){
    List<Colleague> shuffledColleagues = [...colleagues];
    shuffledColleagues.shuffle();

    List<PersonOption> options = [...shuffledColleagues.take(3).map((e) => new PersonOption(e.name, false)),new PersonOption(correctName, true)].toList();

    return options;
  }
}

class GameData {

  final List<PersonOption> options;
  final String imageUrl;

  GameData(this.options, this.imageUrl);

}

class PersonOption {
  final String name;
  final bool correct;

  PersonOption(this.name, this.correct);
}



