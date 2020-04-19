import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiplayer_tic_tac_toe/bloc/index.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameBloc, GameState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: FlatButton(
              color: Colors.grey[300],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  'Play 🎮',
                  style: Theme.of(context)
                      .textTheme
                      .headline
                      .copyWith(color: Colors.black),
                ),
              ),
              onPressed: () {
                BlocProvider.of<GameBloc>(context).add(GameInitialized());
                Navigator.of(context).pushNamed('/gamePage');
              },
            ),
          ),
        );
      },
    );
  }
}
