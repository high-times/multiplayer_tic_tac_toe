import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multiplayer_tic_tac_toe/bloc/index.dart';
import 'package:multiplayer_tic_tac_toe/models/index.dart';
import 'package:multiplayer_tic_tac_toe/repositories/game_constants.dart';
import 'package:multiplayer_tic_tac_toe/widgets/index.dart';

class GameOverPage extends StatelessWidget {
  const GameOverPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  BlocProvider.of<GameBloc>(context).state.winnerPlayerIndex !=
                          null
                      ? "Congratulations!"
                      : "Well, it's a draw!",
                  style: Theme.of(context).textTheme.display1.copyWith(
                      color: BlocProvider.of<GameBloc>(context)
                                  .state
                                  .winnerPlayerIndex !=
                              null
                          ? GameColors.playerColorsMap[
                              BlocProvider.of<GameBloc>(context)
                                  .state
                                  .players[BlocProvider.of<GameBloc>(context)
                                      .state
                                      .winnerPlayerIndex]
                                  .playerNumber]
                          : Colors.grey[800]),
                ),
              ),
            ),
            BlocProvider.of<GameBloc>(context).state.winnerPlayerIndex != null
                ? buildWinnerView(context)
                : Expanded(child: Container()),
            Expanded(
              flex: 2,
              child: RestartButton(),
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildWinnerView(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Icon(FontAwesomeIcons.userNinja,
                size: Theme.of(context).textTheme.display4.fontSize,
                color: GameColors.playerColorsMap[
                    BlocProvider.of<GameBloc>(context)
                        .state
                        .players[BlocProvider.of<GameBloc>(context)
                            .state
                            .winnerPlayerIndex]
                        .playerNumber]),
          ),
          Expanded(
            child: Text(
              BlocProvider.of<GameBloc>(context)
                          .state
                          .players[BlocProvider.of<GameBloc>(context)
                              .state
                              .winnerPlayerIndex]
                          .playerNumber ==
                      PlayerNumber.PLAYER_1
                  ? "Player 1"
                  : "Player 2",
              style: Theme.of(context).textTheme.display1.copyWith(
                    color: GameColors.playerColorsMap[
                        BlocProvider.of<GameBloc>(context)
                            .state
                            .players[BlocProvider.of<GameBloc>(context)
                                .state
                                .winnerPlayerIndex]
                            .playerNumber],
                  ),
            ),
          )
        ],
      ),
    );
  }
}
