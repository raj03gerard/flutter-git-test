import 'dart:convert';
import 'dart:io';
import 'package:postgres_api/models/teams.dart';

import 'storeData_firebase.dart';
import 'models/player.dart';

class ApiData {
  getAPIData() async {
    String searchQuery = 'players';
    String baseUrl = 'https://free-nba.p.rapidapi.com/${searchQuery}';
    Map<String, String> params = {'page': '0', 'per_page': '25'};
    Map<String, String> headers = {
      'X-RapidAPI-Key': '202f64054fmshd65bc423101255ap1fa31fjsn32c05f28050c',
      'X-RapidAPI-Host': 'free-nba.p.rapidapi.com'
    };
    final client = HttpClient();
    final request = await client
        .getUrl(Uri.parse(baseUrl).replace(queryParameters: params));

    for (var key in headers.keys) {
      request.headers.add(key, headers[key] as Object);
    }

    final response = await request.close();

    if (response.statusCode == 200) {
      final body = await response.transform(utf8.decoder).join();
      final jsonBody = jsonDecode(body);
      jsonBody['data'].forEach((data) {
        print("${data['team']} is ${data['name']}'s team!!!!");
        Team team = Team(
            name: data['team']['full_name'],
            tid: data['team']['id'].toString());
        Player player = Player(
            name: "${data['first_name']} ${data['last_name']}",
            pid: "${data['id']}");
        uploadTeam(team);
        uploadPlayer(player, team);
      });
    }
  }
}
