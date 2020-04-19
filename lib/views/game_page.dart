import 'package:flutter/material.dart';
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
    return BlocConsumer<GameBloc, GameState>(
      listener: (context, state) {
        if (state is GameFinished) {
          Navigator.of(context).pushReplacementNamed("/gameOverPage");
        }
      },
      builder: (context, state) {
        if (!(state is GameFinished)) {
          PlayerIcon player1 = PlayerIcon(
            key: player1IconKey,
            playerNumber: state.players[0].playerNumber,
            playerName: "Player 1",
            playerMark: state.players[0].playerMark,
            initialPlayerState: (state.currentPlayerIndex == 0),
          );
          PlayerIcon player2 = PlayerIcon(
            key: player2IconKey,
            playerNumber: state.players[1].playerNumber,
            playerName: "Player 2",
            playerMark: state.players[1].playerMark,
            initialPlayerState: (state.currentPlayerIndex == 1),
          );

          return Scaffold(
            body: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(child: player1),
                          Expanded(child: player2),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          child: GameGrid(),
                        ),
                      ),
                    ),
                    Expanded(child: RestartButton())
                  ],
                ),
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
