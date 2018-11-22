import 'package:flutter/material.dart';
import 'package:dartea/dartea.dart';

void main() {
  final program = Program(
    init,
    update,
    view,
  );
  runApp(CounterApp(program));
}

class CounterApp extends StatelessWidget {
  final Program darteaProgram;

  CounterApp(this.darteaProgram);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter + Dartea = ❤️',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: darteaProgram.build(),
    );
  }
}

///Model - immutable application state
class Model {
  final int counter;
  Model(this.counter);
  Model copyWith({int counter}) => Model(counter ?? this.counter);
}

///Messages - described actions and events, which could affect [Model]
abstract class Message {}

class Increment implements Message {}

class Decrement implements Message {}

///create initial [Model]
Upd<Model, Message> init() => Upd(Model(0));

///Update - the heart of the [dartea] program. Handle messages and current model, returns updated model.
Upd<Model, Message> update(Message msg, Model model) {
  if (msg is Increment) {
    return Upd(model.copyWith(counter: model.counter + 1));
  }
  if (msg is Decrement) {
    return Upd(model.copyWith(counter: model.counter - 1));
  }
  return Upd(model);
}

///View - maps [Model] to the Flutter's Widgets tree
Widget view(BuildContext context, Dispatch<Message> dispatch, Model model) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Flutter + Dartea = ❤'),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '${model.counter}',
            style: Theme.of(context).textTheme.display1,
          ),
          Padding(
            child: RaisedButton.icon(
              label: Text('Increment'),
              icon: Icon(Icons.add),
              onPressed: () => dispatch(Increment()),
            ),
            padding: EdgeInsets.all(5.0),
          ),
          RaisedButton.icon(
            label: Text('Decrement'),
            icon: Icon(Icons.remove),
            onPressed: () => dispatch(Decrement()),
          ),
        ],
      ),
    ),
  );
}
