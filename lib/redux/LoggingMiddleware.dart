import 'package:redux/redux.dart';
import 'package:flutternews/redux/AppState.dart';

loggingMiddleware(Store<AppState> store, action, NextDispatcher next) {
  print('${new DateTime.now()}: $action');
  next(action);
}
