import 'dart:async';
import 'dart:core';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:multiplayer_tic_tac_toe/models/index.dart';
import 'package:multiplayer_tic_tac_toe/repositories/game_constants.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  @override
  GameState get initialState => GameInitial();

  @override
  Stream<GameState> mapEventToState(
    GameEvent event,
  ) async* {
    if (event is GameInitialized) yield GameInitial();
    if (event is GameTurnCompleted) {
      yield processTurn(event);
    }
  }

  GameState processTurn(GameTurnCompleted turnData) {
    int newTurnCount = state.turnCount + 1;
    GameTurnResult gameTurnResult = gameHasFinished(
        state.players[state.currentPlayerIndex],
        turnData.gameTilePlayed,
        state.grid);
    if (gameTurnResult.hasFinished) {
      return GameFinished(state.grid, gameTurnResult.winnerPlayerIndex,
          newTurnCount, state.players, null);
    } else {
      return GameTurn(state.grid, null, newTurnCount, state.players,
          state.currentPlayerIndex == 0 ? 1 : 0);
    }
  }

  GameTurnResult gameHasFinished(
      Player player, GameTile gameTilePlayed, List<GameTile> grid) {
    int listIndexForGameTilePlayed = GameTile
        .LIST_INDEX_MAP[gameTilePlayed.rowIndex][gameTilePlayed.columnIndex];
    grid[listIndexForGameTilePlayed].playerMark = gameTilePlayed.playerMark;
    grid[listIndexForGameTilePlayed].player = player;
    // 0,0 -> 0
    for (var listOfMarkIndices in WinningCombinations.LIST_OF_INDICES) {
      int countOfCombinations = 0;
      for (var currentMarkIndex in listOfMarkIndices) {
        if (grid[currentMarkIndex].playerMark == gameTilePlayed.playerMark) {
          countOfCombinations++;
        }
      }
      if (countOfCombinations == 3) {
        return GameTurnResult(true, state.currentPlayerIndex);
      }
    }

    int filledTilesCount =
        grid.where((v) => (v.playerMark != PlayerMark.NONE)).length;
    return GameTurnResult((filledTilesCount == 9), null);
  }
}

class GameTurnResult {
  final bool hasFinished;
  final int winnerPlayerIndex;

  GameTurnResult(this.hasFinished, this.winnerPlayerIndex);

  @override
  String toString() =>
      'GameTurnResult(hasFinished: $hasFinished, winner: $winnerPlayerIndex)';
}
