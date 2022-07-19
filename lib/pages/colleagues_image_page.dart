import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:know_your_colleague_flutter/domain/colleague.dart';
import 'package:know_your_colleague_flutter/utils/http_methods.dart';

/// Dette er en StatelessWidget. Det er den enkleste komponenten man kan bruke
/// til å lage sin egen Widget. Denne typen widget kan ikke endre seg selv.
/// Men den kan eventuelt bygges på ny med andre verdier som konstruktør-params
/// dersom den er child av en annen widget.
class ColleaguesImagePage extends StatelessWidget {
  const ColleaguesImagePage(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: FutureBuilder(
        future: _getImageUrls(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<String> imageUrls = snapshot.data;
            return GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              children: _allColleaguesAsImageWidgets(imageUrls),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Noe gikk galt ved API-kallet'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  List<Widget> _allColleaguesAsImageWidgets(List<String> imageUrls) {
    return imageUrls
        .map((url) => SizedBox(
              height: 60,
              width: 60,
              child: FittedBox(
                fit: BoxFit.fill,
                child: CachedNetworkImage(imageUrl: url),
              ),
            ))
        .toList();
  }

  Future<List<String>> _getImageUrls() async {
    List<Colleague> colleagues = await fetchColleagues();

    List<String> imageUrls =
        colleagues.map((element) => element.imageUrl).toList();

    log("Got the following image URLs: $imageUrls");

    return imageUrls;
  }
}
