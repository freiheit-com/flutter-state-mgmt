import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CounterModel(42)),
        ],
        child: ProviderScreen());
  }
}

class ProviderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('State Demo: Provider'),
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
        onPressed: () => Provider.of<CounterModel>(context, listen: false).add(1),
        tooltip: 'Add one',
        child: Icon(Icons.add),
      ),
    );
  }
}

class PanelA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CounterModel counter = Provider.of<CounterModel>(context);
    return Text("Panel A: ${counter.count}");
  }
}

class PanelB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CounterModel counter = Provider.of<CounterModel>(context);
    return Text("Panel B: ${counter.count}");
  }
}

class CounterModel extends ChangeNotifier {

  int _count;

  get count => _count;

  CounterModel(this._count);

  void add(int n) {
    _count += n;
    notifyListeners();
  }
}