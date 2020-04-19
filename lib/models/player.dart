import 'package:flutter/foundation.dart';

enum PlayerNumber { PLAYER_1, PLAYER_2 }
enum PlayerMark { X, O, NONE }

class Player {
  final PlayerNumber playerNumber;
  final PlayerMark playerMark;

  Player({@required this.playerNumber, @required this.playerMark})
      : assert(playerMark != null),
        assert(playerNumber != null);

  @override
  String toString() =>
      'Player(playerNumber: $playerNumber, playerMark: $playerMark)';
}
