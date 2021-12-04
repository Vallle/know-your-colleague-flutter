import 'package:flutter/material.dart';
import 'package:know_your_colleague_flutter/pages/colleagues_page.dart';
import 'package:know_your_colleague_flutter/pages/dashboard_page.dart';
import 'package:know_your_colleague_flutter/pages/game_finished_page.dart';
import 'package:know_your_colleague_flutter/pages/game_pages.dart';
import 'package:know_your_colleague_flutter/theme/material_color_generator.dart';
import 'package:know_your_colleague_flutter/theme/palette.dart';

void main() {
  runApp(const MainAppWidget());
}

class MainAppWidget extends StatelessWidget {
  const MainAppWidget({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Know your colleague',
      routes: {'': (context) => const DashboardPage(), '/game': (context) => const GamePage() },
      theme: ThemeData(
        primarySwatch: generateMaterialColor(Palette.primary),
        scaffoldBackgroundColor: generateMaterialColor(Palette.background),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: generateMaterialColor(Palette.secondary)
          ),
        )
      ),
      initialRoute: '',
    );
  }
}