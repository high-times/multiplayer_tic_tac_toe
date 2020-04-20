import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/index.dart';
import '../models/index.dart';
import '../repositories/game_constants.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final _formKey = GlobalKey<FormState>();

  String _player1Name = "🍑";

  String _player2Name = "🍆";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameBloc, GameState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GameConstants.getPlayerMarkWidget(
                          playerMark: PlayerMark.X,
                          size: Theme.of(context).textTheme.display3.fontSize,
                          concatenation: "s"),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          " & ",
                          style: Theme.of(context)
                              .textTheme
                              .display3
                              .copyWith(color: Colors.grey[500]),
                        ),
                      ),
                      GameConstants.getPlayerMarkWidget(
                          playerMark: PlayerMark.O,
                          size: Theme.of(context).textTheme.display3.fontSize,
                          concatenation: "s")
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0, horizontal: 50.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // Add TextFormFields and RaisedButton here.

                          buildPlayerNameTextField(context, (newValue) {
                            _player2Name = newValue;
                          }, GameConstants.getPlayerMarkColor(PlayerMark.X),
                              "🍆"),
                          buildPlayerNameTextField(context, (newValue) {
                            _player1Name = newValue;
                          }, GameConstants.getPlayerMarkColor(PlayerMark.O),
                              "🍑"),
                        ]),
                  ),
                ),
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Container(
                      width: constraints.maxWidth / 2,
                      height: constraints.maxHeight / 2,
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
                                .display2
                                .copyWith(color: Colors.black),
                          ),
                        ),
                        onPressed: () async {
                          await SystemChannels.platform.invokeMethod<void>(
                              'HapticFeedback.mediumImpact');
                          await SystemChannels.platform
                              .invokeMethod<void>('HapticFeedback.vibrate');
                          BlocProvider.of<GameBloc>(context)
                              .add(GameInitialized());
                          Navigator.of(context).pushNamed('/gamePage',
                              arguments: {
                                'player1Name': _player1Name,
                                "player2Name": _player2Name
                              });
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  TextFormField buildPlayerNameTextField(BuildContext context,
      void Function(String newValue) onChanged, Color color, String hintText) {
    return TextFormField(
      onChanged: onChanged,
      cursorColor: color,
      enableSuggestions: true,
      autocorrect: true,
      cursorWidth: 5,
      cursorRadius: Radius.elliptical(5, 5),

      maxLength: 25,
      style: Theme.of(context).textTheme.headline,

      decoration: InputDecoration(
          //hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.red),
          hintText: hintText,
          border: OutlineInputBorder(borderSide: BorderSide(color: color)),
          focusColor: color,
          fillColor: Colors.grey,
          hasFloatingPlaceholder: true,
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: color))),
      // The validator receives the text that the user has entered.
    );
  }
}
