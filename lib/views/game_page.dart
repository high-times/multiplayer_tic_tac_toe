import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/index.dart';
import '../widgets/index.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  GlobalKey player1IconKey = GlobalKey();
  GlobalKey player2IconKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Map playerNames = ModalRoute.of(context).settings.arguments;
    return BlocConsumer<GameBloc, GameState>(
      listener: (context, state) async {
        if (state is GameFinished) {
          await SystemChannels.platform
              .invokeMethod<void>('HapticFeedback.heavyImpact');
          await SystemChannels.platform
              .invokeMethod<void>('HapticFeedback.vibrate');
          Navigator.of(context)
              .pushReplacementNamed("/gameOverPage", arguments: playerNames);
        }
      },
      builder: (context, state) {
        if (!(state is GameFinished)) {
          PlayerIcon player1 = PlayerIcon(
            key: player1IconKey,
            playerNumber: state.players[0].playerNumber,
            playerName: playerNames['player1Name'] ?? "🍑",
            playerMark: state.players[0].playerMark,
            initialPlayerState: (state.currentPlayerIndex == 0),
          );
          PlayerIcon player2 = PlayerIcon(
            key: player2IconKey,
            playerNumber: state.players[1].playerNumber,
            playerName: playerNames['player2Name'] ?? "🍑",
            playerMark: state.players[1].playerMark,
            initialPlayerState: (state.currentPlayerIndex == 1),
          );

          return Scaffold(
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  Flexible(
                    flex: 3,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Flexible(child: player1),
                        Flexible(child: player2),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Container(
                        child: GameGrid(),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: RestartButton()))
                ],
              ),
            ),
          );
        } else {
          return Container(
              child: Center(
            child: Text(
              "Game Over!",
              style: Theme.of(context).textTheme.headline,
            ),
          ));
        }
      },
    );
  }
}
