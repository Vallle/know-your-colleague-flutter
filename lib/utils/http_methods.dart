import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:know_your_colleague_flutter/domain/colleague.dart';

const String _apiToken = "input-token-here"; // TODO endre denne variabelen til en reell verdi

Future<List<Colleague>> fetchColleagues() async {
  dynamic response = await http.get(Uri.parse(
      'https://employee-image-provider.azurewebsites.net/api/fetchallemployeeimageurls?code=$_apiToken'));

  List<dynamic> colleaguesJson = jsonDecode(response.body);

  return colleaguesJson.map((e) => Colleague.fromJson(e)).toList();
}
