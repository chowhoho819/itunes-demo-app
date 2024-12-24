import 'package:bloc/bloc.dart';

class CustomBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    _log('\x1B[35m[State Change] \x1B[0mfrom [${change.currentState.runtimeType}] to [${change.nextState}]', bloc);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    _log('\x1B[31m[Error] $error $stackTrace', bloc);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    _log('\x1B[33m[Transition] \x1B[0mfrom [${transition.currentState.runtimeType}] to [${transition.nextState}] event [${transition.event.runtimeType}]', bloc);
  }

  void _log(String text, BlocBase bloc) {
    String green = '\x1B[32m';
    String reset = '\x1B[0m';
    print("$green[BLOC] \x1B[36m[${bloc.runtimeType}] $text$reset");
  }
}
