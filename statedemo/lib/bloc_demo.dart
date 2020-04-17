import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      create: (context) => CounterBloc(42),
      child: BlocScreen(),
    );
  }
}

class BlocScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('State Demo: BLOC')
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 2,
        children: [
          PanelA(),
          PanelB(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {BlocProvider.of<CounterBloc>(context).add(CounterEvent(CounterEventType.add, 1))},
        tooltip: 'Add one',
        child: Icon(Icons.add),
      ),
    );
  }
}

class PanelA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterBloc, int>(
      builder: (context, count) {
        return Text("Panel A: $count");
      }
    );
  }
}

class PanelB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterBloc, int>(
      builder: (context, count) {
        return Text("Panel B: $count");
      }
    );
  }
}

enum CounterEventType { add }

class CounterEvent {

  CounterEventType type;
  int n;

  CounterEvent(this.type, this.n);
}

class CounterBloc extends Bloc<CounterEvent, int> {

  int _initialCount;

  CounterBloc(this._initialCount);

  @override
  int get initialState => _initialCount;

  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event.type) {
      case CounterEventType.add:
        yield state + event.n;
        break;
    }
  }
}