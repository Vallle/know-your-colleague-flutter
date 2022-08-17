import 'package:flutter/material.dart';
import 'package:know_your_colleague_flutter/pages/colleagues_image_page.dart';
import 'package:know_your_colleague_flutter/pages/colleagues_name_page.dart';
import 'package:know_your_colleague_flutter/theme/palette.dart';

class MainMenuPage extends StatelessWidget {
  const MainMenuPage(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _modeButton(
            context,
            const ColleaguesImagePage('Alle ITverkets ansikter'),
            "Eksempel 1",
          ),
          _modeButton(
            context,
            const ColleaguesNamePage('Alle ITverkets navn'),
            'Eksempel 2',
          ),
        ],
      ),
    );
  }

  Padding _modeButton(BuildContext context, Widget route, String buttonText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        onPressed: () => _navigateToRoute(context, route),
        style: TextButton.styleFrom(
          side: const BorderSide(color: Palette.primary),
        ),
        child: Text(buttonText),
      ),
    );
  }

  Future<dynamic> _navigateToRoute(BuildContext context, Widget route) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => route),
    );
  }
}
