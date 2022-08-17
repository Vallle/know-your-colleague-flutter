import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:know_your_colleague_flutter/domain/colleague.dart';
import 'package:know_your_colleague_flutter/theme/palette.dart';
import 'package:know_your_colleague_flutter/utils/http_methods.dart';

/// Legg merke til at dette er en StatefulWidget. Denne widgeten kan endre seg
/// selv ved å kalle setState(), og dermed er den litt mer kompleks enn en
/// StatelessWidget. Hver gang setState() kalles så kjører den build() på ny.
/// Dersom en variabel har blitt endret inne i setState()-kallet så vil det
/// kunne medføre at build() lager en widget som er ulik forrige gang den kjørte
class ColleaguesNamePage extends StatefulWidget {
  const ColleaguesNamePage(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => _ColleaguesNamePageState();
}

class _ColleaguesNamePageState extends State<ColleaguesNamePage> {
  int _currentPage = 1;
  int _numberOfPages = 1;

  List<String> _names = [];
  Object? _fetchNamesException;
  String? _highlightedWidgetName;

  final _namesPerPage = 10;
  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();

    () async {
      await _getAndSetNames();
    }();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SafeArea(
        child: _buildPageBody(),
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () => _onNextButtonPressed(),
            style: TextButton.styleFrom(
              side: const BorderSide(color: Palette.primary),
            ),
            child: const Text("Neste"),
          ),
        ],
      ),
    );
  }

  Future<void> _onNextButtonPressed() {
    if (_currentPage < _numberOfPages) {
      _currentPage += 1;
      return _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear,
      );
    } else {
      _currentPage = 1;
      return _controller.animateToPage(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear,
      );
    }
  }

  Future<void> _getAndSetNames() async {
    List<Colleague> colleagues = [];
    dynamic exception;

    try {
      colleagues = await fetchColleagues();
    } catch (ex, stacktrace) {
      exception = ex;
      log("Exception $ex");
      log("StackTrace $stacktrace");
    }

    List<String> names = colleagues.map((element) => element.name).toList();

    log("Got the following names: $names");

    setState(() {
      _names = names;
      _numberOfPages = (names.length / _namesPerPage).ceil();
      _fetchNamesException = exception;
    });
  }

  Widget _buildPageBody() {
    if (_names.isNotEmpty) {
      return PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _controller,
        children: _buildNameWidgets(context, _names),
      );
    } else if (_fetchNamesException != null) {
      return const Center(child: Text('Noe gikk galt ved API-kallet'));
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  List<Widget> _buildNameWidgets(BuildContext context, List<String> names) {
    List<Widget> nameWidgets = names.map((name) {
      if (name == _highlightedWidgetName) {
        return TextButton(
          style: TextButton.styleFrom(
            side: const BorderSide(color: Palette.primary),
          ),
          onPressed: () => log("No need to do anything"),
          child: Text(name),
        );
      } else {
        return TextButton(
          onPressed: () {
            setState(() {
              _highlightedWidgetName = name;
            });
          },
          child: Text(name),
        );
      }
    }).toList();

    return List.generate(
      _numberOfPages,
      (index) {
        int nameIndexStart = index * _namesPerPage;
        bool isLastPage = (index + 1) == _numberOfPages;

        if (isLastPage) {
          return ListView(children: nameWidgets.sublist(nameIndexStart));
        } else {
          return ListView(
              children: nameWidgets.sublist(
                  nameIndexStart, nameIndexStart + _namesPerPage));
        }
      },
    );
  }
}
