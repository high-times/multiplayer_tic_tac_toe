import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

class GameConstants {
  // static final Map<PlayerNumber, Color> playerColorsMap = {
  //   PlayerNumber.PLAYER_1: Colors.red[400],
  //   PlayerNumber.PLAYER_2: Colors.blue[400],
  //   null: Colors.grey
  // };

  static Color getPlayerMarkColor(PlayerMark playerMark,
      [double opacity = 1.0]) {
    switch (playerMark) {
      case PlayerMark.X:
        return Colors.purple[800].withOpacity(opacity);
        break;
      case PlayerMark.O:
        return Colors.deepOrange[400].withOpacity(opacity);
      default:
        return Colors.blueGrey[400].withOpacity(opacity);
    }
  }

  static Widget getPlayerMarkWidget(
      {@required PlayerMark playerMark,
      @required double size,
      String concatenation = ""}) {
    var center = Text(
      "🍆$concatenation",
      style: Typography.blackMountainView.display3.copyWith(
        fontFamily: 'Permanent Marker',
        fontSize: size,
        color: getPlayerMarkColor(playerMark),
      ),
    );
    switch (playerMark) {
      case PlayerMark.NONE:
        return Container();
        break;
      case PlayerMark.O:
        return Text(
          "🍑$concatenation",
          style: Typography.blackMountainView.display3.copyWith(
            fontFamily: 'Permanent Marker',
            fontSize: size,
            color: getPlayerMarkColor(playerMark),
          ),
        );

        break;
      case PlayerMark.X:
        return center;
        break;
      default:
        return Container();
    }
  }
}
