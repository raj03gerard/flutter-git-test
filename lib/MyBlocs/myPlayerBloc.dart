import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:postgres_api/dataOperations/getAllPlayers.dart';

class MyPlayerBloc {
  final stateStreamController = StreamController<QuerySnapshot>();
  StreamSink<QuerySnapshot> get playerSink => stateStreamController.sink;
  Stream<QuerySnapshot> get playerStream => stateStreamController.stream;

  fetchPlayer(String teamName) async {
    QuerySnapshot playersList =
        await FetchDataFromFirestore().getPlayerByTeam(teamName);
    playerSink.add(playersList);
  }

  void dispose() {
    stateStreamController.close();
  }
}
