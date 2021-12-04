import 'package:flutter/material.dart';
import 'package:know_your_colleague_flutter/transitions/slide_transitions.dart';

import 'game_pages.dart';


class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, SlideRightRoute(page: GamePage()));
          },
          child: const Text('Nytt spill'),
        ),
      ),
    );
  }
}
