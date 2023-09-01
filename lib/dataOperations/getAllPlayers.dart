import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:postgres_api/models/player.dart';
import 'package:postgres_api/models/teams.dart';

class FetchDataFromFirestore {
  Future<QuerySnapshot> getPlayerByTeam(String teamName) async {
    QuerySnapshot teamsSnapshot = await FirebaseFirestore.instance
        .collection('teams')
        .where('name', isEqualTo: teamName)
        .get();

    DocumentReference teamRef = teamsSnapshot.docs[0].reference;

    List<Map> players = [];
    QuerySnapshot playersQuerySnapshot = await FirebaseFirestore.instance
        .collection('players')
        .where('team', isEqualTo: teamRef)
        .get();

    setPlayersForTeams(playersQuerySnapshot, teamRef);
    return playersQuerySnapshot;
  }

  setPlayersForTeams(
      QuerySnapshot playersQuerySnapshot, DocumentReference teamRef) {
    List playersList = [];
    playersQuerySnapshot.docs.forEach((element) {
      print("${element['name']}: ${element['team']}");
      playersList.add(element.reference);
      // players.add({'name': element['name'], 'team': element['team']});
    });
    teamRef.update({'players': playersList});
  }

  setTeamForPlayer(String teamName, String playerName) async {
    QuerySnapshot teamSnapshot = await FirebaseFirestore.instance
        .collection('teams')
        .where('name', isEqualTo: teamName)
        .get();
    var teamRef = teamSnapshot.docs[0].reference;
    await FirebaseFirestore.instance
        .collection('players')
        .where('name', isEqualTo: playerName)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        element.reference.update({'team': teamRef});
      });
    });
  }
}
