import 'package:flutter/material.dart';
import 'package:flutternews/redux/AppState.dart';
import 'package:flutternews/redux/Actions.dart';
import 'package:flutter_redux/flutter_redux.dart';

enum BUTTONCASE { INCREMENT, DECREMENT }

class MainBody extends StatelessWidget {
  Widget _createButton(BUTTONCASE buttoncase) {
    return StoreConnector<AppState, VoidCallback>(
      converter: (store) {
        return buttoncase == BUTTONCASE.INCREMENT
            ? () => store.dispatch(incrementAsyncAction)
            : () => store.dispatch(decrementAsyncAfter(Duration(seconds: 6)));
      },
      builder: (context, method) {
        return RaisedButton(
          onPressed: method,
          child: Text(
            buttoncase == BUTTONCASE.INCREMENT ? '+' : '-',
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          color: buttoncase == BUTTONCASE.INCREMENT
              ? Colors.teal
              : Colors.deepOrange,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: StoreConnector<AppState, String>(
                  converter: (store) => store.state.counter.toString(),
                  builder: (context, currenCount) => Text(currenCount),
                )),
            _createButton(BUTTONCASE.INCREMENT),
            _createButton(BUTTONCASE.DECREMENT)
          ],
        ),
      ),
    );
  }
}
