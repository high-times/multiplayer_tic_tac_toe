import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/index.dart';
import '../models/index.dart';
import '../repositories/game_constants.dart';

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
    widgetToShow = GameConstants.getPlayerMarkWidget(
      playerMark: playerMark,
      size: Theme.of(context).textTheme.display3.fontSize,
    );

    return Container(
      child: widgetToShow,
    );
  }

  Color getMarkColor(BuildContext context) {
    return GameConstants.getPlayerMarkColor(BlocProvider.of<GameBloc>(context)
                .state
                .grid[widget.index]
                ?.player
                ?.playerMark ??
            null)
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
