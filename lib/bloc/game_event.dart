part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();
}

class GameInitialized extends GameEvent {
  @override
  List<Object> get props => [];
}

class GameTurnCompleted extends GameEvent {
  final GameTile gameTilePlayed;

  GameTurnCompleted(this.gameTilePlayed);

  @override
  List<Object> get props => [gameTilePlayed];

  @override
  String toString() => 'GameTurnCompleted(gameTilePlayed: $gameTilePlayed)';
}
