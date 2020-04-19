import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multiplayer_tic_tac_toe/repositories/game_constants.dart';

import '../bloc/index.dart';
import '../models/index.dart';

class MarkWidget extends StatefulWidget {
  final int index;

  const MarkWidget({Key key, this.index}) : super(key: key);
  @override
  _MarkWidgetState createState() => _MarkWidgetState();
}

class _MarkWidgetState extends State<MarkWidget> {
  //PlayerNumber playerNumber;

  @override
  Widget build(BuildContext context) {
    PlayerMark playerMark =
        BlocProvider.of<GameBloc>(context).state.grid[widget.index].playerMark;

    Widget widgetToShow;
    switch (playerMark) {
      case PlayerMark.X:
        widgetToShow = Icon(
          FontAwesomeIcons.times,
          color: getMarkColor(context),
          size: Theme.of(context).textTheme.display1.fontSize,
        );
        break;
      case PlayerMark.O:
        widgetToShow = Icon(
          FontAwesomeIcons.solidDotCircle,
          color: getMarkColor(context),
          size: Theme.of(context).textTheme.display1.fontSize,
        );
        break;
      case PlayerMark.NONE:
      default:
        widgetToShow = Container();
        break;
    }
    return Container(
      child: widgetToShow,
    );
  }

  Color getMarkColor(BuildContext context) {
    return GameColors.playerColorsMap[BlocProvider.of<GameBloc>(context)
            .state
            .grid[widget.index]
            .player
            .playerNumber]
        .withOpacity(BlocProvider.of<GameBloc>(context)
                    .state
                    .grid[widget.index]
                    .player ==
                BlocProvider.of<GameBloc>(context).state.players[
                    BlocProvider.of<GameBloc>(context).state.currentPlayerIndex]
            ? 1.0
            : 0.3);
  }
}
