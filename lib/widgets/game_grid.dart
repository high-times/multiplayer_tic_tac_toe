import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiplayer_tic_tac_toe/bloc/index.dart';
import 'package:multiplayer_tic_tac_toe/models/index.dart';

import 'index.dart';

class GameGrid extends StatefulWidget {
  @override
  _GameGridState createState() => _GameGridState();
}

class _GameGridState extends State<GameGrid> {
  @override
  Widget build(BuildContext context) {
    //GameBloc gameBloc = ;
    return GridView.count(
      padding: EdgeInsets.all(8),
      childAspectRatio: 1,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      children: List.generate(9, (index) {
        return InkWell(
          onTap: () {
            if (BlocProvider.of<GameBloc>(context)
                    .state
                    .grid[index]
                    .playerMark ==
                PlayerMark.NONE) {
              GameTile gameTilePlayed = GameTile(
                  rowIndex: GameTile.ROW_INDICES_MAP[index],
                  columnIndex: GameTile.COLUMN_INDICES_MAP[index]);

              gameTilePlayed.playerMark = BlocProvider.of<GameBloc>(context)
                  .state
                  .players[BlocProvider.of<GameBloc>(context)
                      .state
                      .currentPlayerIndex]
                  .playerMark;

              BlocProvider.of<GameBloc>(context).add(
                GameTurnCompleted(
                  gameTilePlayed,
                ),
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
            ),
            child: MarkWidget(index: index),
          ),
        );
      }),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
    );
  }
}
