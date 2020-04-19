import 'package:flutter/material.dart';
import 'package:multiplayer_tic_tac_toe/models/index.dart';

class WinningCombinations {
  static const List<List<int>> LIST_OF_INDICES = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ];
}

class GameColors {
  static final Map<PlayerNumber, Color> playerColorsMap = {
    PlayerNumber.PLAYER_1: Colors.red[400],
    PlayerNumber.PLAYER_2: Colors.blue[400]
  };
}
