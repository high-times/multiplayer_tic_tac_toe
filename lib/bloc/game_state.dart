part of 'game_bloc.dart';

abstract class GameState extends Equatable {
  final List<Player> players;
  final int currentPlayerIndex;
  final List<GameTile> grid;
  final int winnerPlayerIndex;
  final int turnCount;

  GameState(this.grid, this.winnerPlayerIndex, this.turnCount, this.players,
      this.currentPlayerIndex);
  List<Object> get props =>
      [grid, winnerPlayerIndex, turnCount, players, currentPlayerIndex];

  @override
  String toString() {
    return 'GameState(players: $players, currentPlayer: $currentPlayerIndex, grid: $grid, winner: $winnerPlayerIndex, turnCount: $turnCount)';
  }
}

class GameInitial extends GameState {
  GameInitial()
      : super(
            getInitialGrid(),
            null,
            1,
            [
              Player(
                  playerNumber: PlayerNumber.PLAYER_1,
                  playerMark: PlayerMark.O),
              Player(
                  playerNumber: PlayerNumber.PLAYER_2,
                  playerMark: PlayerMark.X),
            ],
            getRandomNumberLessThan2());

  @override
  List<Object> get props => [];

  static getRandomNumberLessThan2() => Random.secure().nextInt(2);

  static List<GameTile> getInitialGrid() {
    List<GameTile> tiles = List();
    for (var i = 0; i < 9; i++) {
      int rowIndex = GameTile.ROW_INDICES_MAP[i];
      int columnIndex = GameTile.COLUMN_INDICES_MAP[i];
      tiles.add(new GameTile(rowIndex: rowIndex, columnIndex: columnIndex));
    }
    return tiles;
  }
}

class GameTurn extends GameState {
  GameTurn(List<GameTile> grid, int winnerPlayerIndex, int turnCount,
      List<Player> players, int currentPlayerIndex)
      : super(grid, winnerPlayerIndex, turnCount, players, currentPlayerIndex);
}

class GameFinished extends GameState {
  GameFinished(List<GameTile> grid, int winnerPlayerIndex, int turnCount,
      List<Player> players, int currentPlayerIndex)
      : super(grid, winnerPlayerIndex, turnCount, players, currentPlayerIndex);
}
