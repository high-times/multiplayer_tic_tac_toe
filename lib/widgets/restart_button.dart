import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiplayer_tic_tac_toe/bloc/index.dart';

class RestartButton extends StatelessWidget {
  const RestartButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
        color: Colors.grey[300],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            '🥳  Restart',
            style: Theme.of(context)
                .textTheme
                .headline
                .copyWith(color: Colors.black),
          ),
        ),
        onPressed: () {
          BlocProvider.of<GameBloc>(context).add(GameInitialized());
          Navigator.of(context).pushReplacementNamed('/gamePage');
        },
      ),
    );
  }
}
