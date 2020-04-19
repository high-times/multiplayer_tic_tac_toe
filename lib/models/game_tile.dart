import 'package:flutter/foundation.dart';

import 'index.dart';

class GameTile {
  static const COLUMN_INDICES_MAP = [0, 1, 2, 0, 1, 2, 0, 1, 2];
  static const ROW_INDICES_MAP = [0, 0, 0, 1, 1, 1, 2, 2, 2];

  static const LIST_INDEX_MAP = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ];

  final int rowIndex;
  final int columnIndex;

  PlayerMark _playerMark = PlayerMark.NONE;

  Player _player;

  GameTile({
    @required this.rowIndex,
    @required this.columnIndex,
  })  : assert(rowIndex != null),
        assert(columnIndex != null);

  set playerMark(selectedPlayerMark) => _playerMark = selectedPlayerMark;

  get playerMark => _playerMark;

  set player(player) => _player = player;
  get player => _player;

  @override
  String toString() {
    return 'GameTile(rowIndex: $rowIndex, columnIndex: $columnIndex, _playerMark: $_playerMark, _player: $_player)';
  }
}
