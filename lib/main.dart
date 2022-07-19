import 'package:flutter/material.dart';
import 'package:know_your_colleague_flutter/pages/main_menu_page.dart';
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
      title: 'Navneleken',
      theme: ThemeData(
        primarySwatch: generateMaterialColor(Palette.primary),
      ),
      home: const MainMenuPage('Velg modus'),
    );
  }
}
