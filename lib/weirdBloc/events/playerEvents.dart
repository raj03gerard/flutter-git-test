import 'package:postgres_api/models/player.dart';

abstract class PlayerEvent {}

class PlayerTeamUpdatedEvent implements PlayerEvent {
  final Player player;

  PlayerTeamUpdatedEvent({required this.player});
}
