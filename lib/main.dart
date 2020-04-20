import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import 'bloc/index.dart';
import 'views/index.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print('onEvent $event');
  }

  @override
  onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('onTransition $transition');
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print('onError $error');
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameBloc(),
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.red,
            fontFamily: 'Permanent Marker',
          ),
          initialRoute: '/',
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/':
                return PageTransition(
                  child: StartPage(),
                  type: PageTransitionType.fade,
                  duration: Duration(milliseconds: 50),
                  settings: settings,
                );
                break;
              case '/gamePage':
                return PageTransition(
                  child: GamePage(),
                  duration: Duration(milliseconds: 50),
                  type: PageTransitionType.fade,
                  settings: settings,
                );
                break;
              case '/gameOverPage':
                return PageTransition(
                  child: GameOverPage(),
                  type: PageTransitionType.scale,
                  alignment: Alignment.center,
                  duration: Duration(milliseconds: 500),
                  settings: settings,
                );
                break;
              default:
                return null;
            }
          },
        ),
      ),
    );
  }
}
