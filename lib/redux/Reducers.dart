import 'package:flutternews/redux/Actions.dart';
import 'package:flutternews/redux/AppState.dart';

AppState counterReducer(AppState state, action) {
  if (action is IncrementAction) {
    return AppState(counter: state.counter + action.payload);
  } else if (action is DecrementAction) {
    return AppState(counter: state.counter - action.payload);
  }
  return state;
}
