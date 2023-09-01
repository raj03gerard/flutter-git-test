import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/player.dart';
import 'models/teams.dart';

uploadPlayer(Player player, Team team) async {
  // player.pid = "${player.name}_${getRandomString(5)}";
  await FirebaseFirestore.instance
      .collection("players")
      .withConverter(
        fromFirestore: Player.fromFirestore,
        toFirestore: (Player player, options) => player.toFirestore(),
      )
      .doc(player.pid)
      .set(player);

  await FirebaseFirestore.instance.collection("players").doc(player.pid).update(
      {'team': FirebaseFirestore.instance.collection("teams").doc(team.tid)});
}

getPlayer(String name) async {
  var playerRef = await FirebaseFirestore.instance
      .collection("players")
      .withConverter(
          fromFirestore: Player.fromFirestore,
          toFirestore: (Player player, _) => player.toFirestore())
      .where("name", arrayContains: name);
  QuerySnapshot playerSnapshot = await playerRef.get();
  print(playerSnapshot.docs);
}

uploadTeam(Team team) async {
  // team.tid = "${team.name}_${getRandomString(5)}";
  await FirebaseFirestore.instance
      .collection("teams")
      .withConverter(
        fromFirestore: Team.fromFirestore,
        toFirestore: (Team team, options) => team.toFirestore(),
      )
      .doc(team.tid)
      .set(team);
}
