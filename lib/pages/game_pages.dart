import 'package:flutter/material.dart';
import 'package:know_your_colleague_flutter/transitions/slide_transitions.dart';

import 'game_finished_page.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, SlideRightRoute(page: GameFinishedPage(10)));
          },
          child: const Text('Ferdig'),
        ),
      ),
    );
  }
}

