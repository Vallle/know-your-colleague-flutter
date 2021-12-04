import 'package:flutter/material.dart';
import 'package:know_your_colleague_flutter/pages/dashboard_page.dart';
import 'package:know_your_colleague_flutter/transitions/slide_transitions.dart';

class GameFinishedPage extends StatelessWidget {
  const GameFinishedPage(this.score,{Key? key}) : super(key: key);
  final int score;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(context, SlideRightRoute(page: DashboardPage()), ModalRoute.withName(''));
          },
          child: const Text('Dashboard'),
        ),
      ),
    );
  }
}
