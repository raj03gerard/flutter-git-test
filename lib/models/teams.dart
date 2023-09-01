import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class Team {
  String? name;
  List<String>? players = [];
  String? tid;
  // set tid(val) {
  //   _tid = val;
  // }

  Team({this.name, this.players, this.tid});

  factory Team.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Team(name: data?['name'], players: data?['team'], tid: data?['tid']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (players != null) "players": players,
      if (tid != null) "tid": tid,
    };
  }
}
