import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multiplayer_tic_tac_toe/bloc/index.dart';
import 'package:multiplayer_tic_tac_toe/models/index.dart';
import 'package:multiplayer_tic_tac_toe/repositories/game_constants.dart';
import 'package:multiplayer_tic_tac_toe/widgets/index.dart';
import 'package:shimmer/shimmer.dart';

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
                      ? "Winner!"
                      : "Well, it's a draw!",
                  style: Theme.of(context).textTheme.display1.copyWith(),
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
    Map playerNames = ModalRoute.of(context).settings.arguments;

    return Expanded(
      flex: 4,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: [
                GameConstants.getPlayerMarkWidget(
                    playerMark: BlocProvider.of<GameBloc>(context)
                        .state
                        .players[BlocProvider.of<GameBloc>(context)
                            .state
                            .winnerPlayerIndex]
                        .playerMark,
                    size: 120),
                Opacity(
                  opacity: 0.3,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.withOpacity(0.4),
                    highlightColor: Colors.white.withOpacity(1),
                    direction: ShimmerDirection.btt,
                    child: GameConstants.getPlayerMarkWidget(
                        playerMark: BlocProvider.of<GameBloc>(context)
                            .state
                            .players[BlocProvider.of<GameBloc>(context)
                                .state
                                .winnerPlayerIndex]
                            .playerMark,
                        size: 120),
                  ),
                ),
              ],
            ),
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
                  ? playerNames["player1Name"] ?? ""
                  : playerNames["player2Name"] ?? "",
              style: Theme.of(context).textTheme.display1.copyWith(
                    color: GameConstants.getPlayerMarkColor(
                        BlocProvider.of<GameBloc>(context)
                            .state
                            .players[BlocProvider.of<GameBloc>(context)
                                .state
                                .winnerPlayerIndex]
                            .playerMark),
                  ),
            ),
          )
        ],
      ),
    );
  }
}
