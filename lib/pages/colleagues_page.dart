import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:know_your_colleague_flutter/domain/colleague.dart';

class ColleaguesPage extends StatelessWidget {
  const ColleaguesPage(this.title, {Key? key}) : super(key: key);

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
            return const Center(child: Text('Funket ikke :('));
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
                child: CachedNetworkImage(imageUrl: url),
                fit: BoxFit.fill,
              ),
            ))
        .toList();
  }

  Future<List<String>> _getImageUrls() async {
    dynamic response = await _fetchPeople();
    List<dynamic> colleaguesJson = jsonDecode(response.body);

    List<Colleague> colleagues =
        colleaguesJson.map((e) => Colleague.fromJson(e)).toList();

    List<String> imageUrls =
        colleagues.map((element) => element.imageUrl).toList();

    log("Got the following image URLs: $imageUrls");

    return imageUrls;
  }

  Future<http.Response> _fetchPeople() {
    return http.get(Uri.parse(
        'https://url-to-api-will-be-provided.net'));
  }
}
