import 'package:flutter/material.dart';
import 'package:know_your_colleague_flutter/pages/dashboard_page.dart';

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
            Navigator.of(context).push(_createRoute());
          },
          child: const Text('Dashboard'),
        ),
      ),
    );
  }
}
Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const DashboardPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}
