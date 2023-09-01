import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';

abstract class PlayerState extends Equatable {}

class PlayerInitial extends PlayerState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PlayerUpdated extends PlayerState {
  QuerySnapshot querySnapshot;

  PlayerUpdated({required this.querySnapshot});
  @override
  // TODO: implement props
  List<Object?> get props => [querySnapshot];
}
