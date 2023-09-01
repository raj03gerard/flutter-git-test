import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postgres_api/weirdBloc/events/playerEvents.dart';
import 'package:postgres_api/dataOperations/getAllPlayers.dart';
import 'package:postgres_api/weirdBloc/states/playerStates.dart';
import 'package:firebase_core/firebase_core.dart';

class PlayersBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayersBloc() : super(PlayerInitial()) {
    on<PlayerTeamUpdatedEvent>((event, emit) async {
      print("Emitting query snapshot");
      QuerySnapshot querySnapshot =
          await FetchDataFromFirestore().getPlayerByTeam("Boston Celtics");

      emit(querySnapshot);
    });
  }
}
