import 'package:redux/redux.dart';
import 'package:flutternews/redux/AppState.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'Reducers.dart';
import 'LoggingMiddleware.dart';

final store = Store<AppState>(counterReducer,
    initialState: AppState(counter: 0),
    middleware: [loggingMiddleware, thunkMiddleware]);
