import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();
String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

class Player {
  String? name;
  String? team;
  String? pid;
  Player({this.name, this.team, this.pid});

  factory Player.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Player(name: data?['name'], team: data?['team'], pid: data?['pid']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (team != null) "team": team,
      if (pid != null) "pid": pid,
    };
  }
}
