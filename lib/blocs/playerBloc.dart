import 'dart:convert';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postgres_api/models/player.dart';
import 'package:postgres_api/storeData_firebase.dart';

enum PlayerEvents { Fetch, Update }

class PlayerBloc {
  final _stateStreamController = StreamController<QuerySnapshot>();
  StreamSink<QuerySnapshot> get _playerSink => _stateStreamController.sink;
  Stream<QuerySnapshot> get playersStream => _stateStreamController.stream;

  final _eventStreamController = StreamController();
  StreamSink get eventSink => _eventStreamController.sink;
  Stream get _eventStream => _eventStreamController.stream;

  PlayerBloc() {
    _eventStream.listen((event) async {
      if (event == PlayerEvents.Fetch) {
        QuerySnapshot playerSnapshot = await getPlayer("Billy Preston");
        print(playerSnapshot.docs);
        _playerSink.add(playerSnapshot);
      }
    });
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
