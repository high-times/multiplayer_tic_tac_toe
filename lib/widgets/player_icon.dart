import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multiplayer_tic_tac_toe/bloc/index.dart';
import 'package:multiplayer_tic_tac_toe/models/index.dart';
import 'package:multiplayer_tic_tac_toe/repositories/game_constants.dart';

class PlayerIcon extends StatefulWidget {
  final String playerName;
  final PlayerNumber playerNumber;
  final PlayerMark playerMark;

  final bool initialPlayerState;

  const PlayerIcon(
      {Key key,
      @required this.playerName,
      @required this.initialPlayerState,
      @required this.playerNumber,
      this.playerMark})
      : assert(playerName != null),
        assert(initialPlayerState != null),
        assert(playerNumber != null),
        super(key: key);

  @override
  _PlayerIconState createState() => _PlayerIconState(initialPlayerState);
}

class _PlayerIconState extends State<PlayerIcon> {
  bool isCurrentPlayer;

  _PlayerIconState(this.isCurrentPlayer);

  @override
  Widget build(BuildContext context) {
    isCurrentPlayer = BlocProvider.of<GameBloc>(context)
            .state
            .players[
                BlocProvider.of<GameBloc>(context).state.currentPlayerIndex]
            .playerNumber ==
        widget.playerNumber;

    Color color = GameColors.playerColorsMap[widget.playerNumber];
    color = (isCurrentPlayer) ? color : color.withOpacity(0.3);
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
              child:
                  FaIcon(FontAwesomeIcons.userNinja, size: 48, color: color)),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                (isCurrentPlayer)
                    ? Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          FontAwesomeIcons.solidCheckCircle,
                          size: Theme.of(context).textTheme.title.fontSize,
                          color: color,
                        ),
                      )
                    : Container(),
                Text(
                  widget.playerName,
                  style: Theme.of(context)
                      .textTheme
                      .headline
                      .copyWith(color: color),
                ),
              ],
            ),
          ),
          Expanded(
              child: Icon(
                  widget.playerMark == PlayerMark.X
                      ? FontAwesomeIcons.times
                      : FontAwesomeIcons.solidDotCircle,
                  color: color,
                  size: Theme.of(context).textTheme.display1.fontSize))
        ],
      ),
    );
  }
}
